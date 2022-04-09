import 'package:flutter/src/widgets/basic.dart';
import 'package:get/get.dart';
import 'package:taptap/app/data/models/authorize_param.dart';
import 'package:webview_flutter/webview_flutter.dart';
part 'secret_key.dart';

class ApiProvider extends GetConnect {
  final String _baseUrl = "https://testapi.openbanking.or.kr";
  AuthorizeResponse authResponse = AuthorizeResponse();

  authorizeToken() async {
    WebViewController _webViewController;

    final _parameter = AuthorizeParam.regular(CLINET_KEY);
    final responseUri = "$_baseUrl/oauth/2.0/authorize${_parameter.stringify}";
    Response response = await get(responseUri);

    if (response.statusCode == 200) {
      Get.dialog(Padding(
        padding: const EdgeInsets.all(16.0),
        child: WebView(
          initialUrl: responseUri,
          onWebViewCreated: (WebViewController webViewController) {
            _webViewController = webViewController;
          },
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (url) {
            print("FINISH : $url");
          },
          navigationDelegate: (request) {
            print("NAVI : ${request.url}");
            if (request.url.contains("https://www.kftc.or.kr/?code")) {
              authResponse = AuthorizeResponse.uri(request.url);
              print("FINAL : ${authResponse.code}");
            }
            return NavigationDecision.navigate;
          },
        ),
      ));
    }
  }
}
