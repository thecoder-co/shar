class User {
  String? refreshToken;
  String? accessToken;
  String? shareCode;
  String? username;

  User({
    this.refreshToken,
    this.accessToken,
    this.shareCode,
    this.username,
  });

  factory User.fromJson(
      {String? accessToken,
      String? refreshToken,
      String? shareCode,
      String? username}) {
    return User(
      accessToken: accessToken,
      refreshToken: refreshToken,
      shareCode: shareCode,
      username: username,
    );
  }
}
