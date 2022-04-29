import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taptap/app/core/utils/headers.dart';
import 'package:taptap/app/data/models/authorize_param.dart';
import 'package:taptap/app/data/models/issue_token.dart';
import 'package:taptap/app/data/models/user.dart';
import 'package:taptap/app/data/service/auth/service.dart';
import 'package:webview_flutter/webview_flutter.dart';
part 'secret_key.dart';

class ApiProvider extends GetConnect {
  final String _baseUrl = "https://testapi.openbanking.or.kr";

  Future<dynamic> authorize() async {
    WebViewController _webViewController;

    final _parameter = AuthorizeParam.regular(CLINET_KEY);
    final responseUri = "$_baseUrl/oauth/2.0/authorize${_parameter.stringify}";
    Response response = await get(responseUri);

    if (response.statusCode == 200) {
      return Get.dialog(Padding(
        padding: const EdgeInsets.all(16.0),
        child: WebView(
          initialUrl: responseUri,
          onWebViewCreated: (WebViewController webViewController) {
            _webViewController = webViewController;
          },
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (url) async {
            if (url.contains("https://www.kftc.or.kr/?code")) {
              Get.back(result: AuthorizeResponse.uri(url));
              return;
            }
          },
          navigationDelegate: (request) async {
            return NavigationDecision.navigate;
          },
        ),
      ));
    }
  }

  Future<IssueTokenResponse> issueToken(String code) async {
    final _parameter = IssueTokenParam.regular(code, CLINET_KEY, CLIENT_SECRET);

    Response response = await post(
        "$_baseUrl/oauth/2.0/token", _parameter.stringify,
        contentType: 'application/x-www-form-urlencoded',
        headers: HeadersAPI().getHeaders());

    return IssueTokenResponse.fromJson(response.body);
  }

  Future<IssueTokenResponse> issueRefreshToken(String refreshToken) async {
    final _parameter =
        IssueTokenParam.refresh(CLINET_KEY, CLIENT_SECRET, refreshToken);

    Response response = await post(
        "$_baseUrl/oauth/2.0/token", _parameter.refreshStringify,
        contentType: 'application/x-www-form-urlencoded',
        headers: HeadersAPI().getHeaders());

    return IssueTokenResponse.fromJson(response.body);
  }

  Future<IssueTokenResponse> login() async {
    final auth = await authorize();
    final issue = await issueToken(auth.code);
    return issue;
  }

  Future<UserInfo> getUserInfo() async {
    Response response = await get(
        "$_baseUrl/v2.0/user/me?user_seq_no=${Get.find<AuthService>().seq_no}",
        headers: HeadersAPI()
            .getHeaders(auth: true, token: Get.find<AuthService>().token));

    if (response.statusCode == 401) {
      // issueRefreshToken(Get.find<AuthService>.refreshToken); HOW TO?
    }
    return UserInfo.fromJson(response.body);
  }
}
