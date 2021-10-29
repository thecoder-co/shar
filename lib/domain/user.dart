class User {
  String? refreshToken;

  String? accessToken;

  User({
    this.refreshToken,
    this.accessToken,
  });

  factory User.fromJson({String? accessToken, String? refreshToken}) {
    return User(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
