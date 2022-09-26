class ResLogin {
  int? userId;
  int? roleId;
  String? tokenKey;
  String? token;

  ResLogin({this.userId, this.roleId, this.tokenKey, this.token});

  ResLogin.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    roleId = json['role_id'];
    tokenKey = json['token_key'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['role_id'] = roleId;
    data['token_key'] = tokenKey;
    data['token'] = token;
    return data;
  }
}
