class IssueTokenParam {
  final String code;
  final String clientId;
  final String clientSecret;
  final String redirectUri;
  final String grantType;

  const IssueTokenParam(
      {required this.code,
      required this.clientId,
      required this.clientSecret,
      this.redirectUri = "https://www.kftc.or.kr",
      this.grantType = "authorization_code"});
  factory IssueTokenParam.regular(String code, String id, String secret) {
    final param =
        IssueTokenParam(code: code, clientId: id, clientSecret: secret);
    return param;
  }

  String get stringify {
    String result = "";
    result += "client_id=$clientId&";
    result += "client_secret=$clientSecret&";
    result += "code=$code&";
    result += "redirect_uri=$redirectUri&";
    result += "grant_type=$grantType";
    return result;
  }
}

class IssueTokenResponse {
  final String accessToken;
  final String refreshToken;
  final String userSeqNo;

  const IssueTokenResponse(
      {required this.accessToken,
      required this.refreshToken,
      required this.userSeqNo});
  factory IssueTokenResponse.fromJson(Map<String, dynamic> json) {
    return IssueTokenResponse(
        accessToken: json['access_token'],
        refreshToken: json['refresh_token'],
        userSeqNo: json['user_seq_no']);
  }
}
