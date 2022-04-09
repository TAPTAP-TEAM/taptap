class AuthorizeParam {
  final String responseType;
  final String clientId;
  final String redirectUri;
  final String scope;
  final String state;
  final String authType;

  const AuthorizeParam({
    this.responseType = "code",
    required this.clientId,
    this.redirectUri = "https://www.kftc.or.kr",
    this.scope = "login transfer",
    this.state = "b80BLsfigm9OokPTjy03elbJqRHOfGSY",
    this.authType = "0",
  });

  String get stringify {
    String result = "?";
    result += "response_type=$responseType&";
    result += "client_id=$clientId&";
    result += "redirect_uri=$redirectUri&";
    result += "scope=$scope&";
    result += "state=$state&";
    result += "auth_type=$authType";
    return result;
  }

  factory AuthorizeParam.regular(String clientId) {
    final param = AuthorizeParam(clientId: clientId);
    return param;
  }
}
