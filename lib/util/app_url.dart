class AppUrl {
  static const String liveBaseURL = "https://kubool-clone-api.herokuapp.com";
  static const String localURL = "https://kubool-clone-api.herokuapp.com";
  static const String baseURL = liveBaseURL;
  static const String register = baseURL + "/api/user/signup/";
  static const String login = baseURL + "/api/user/login/";
  static const String getUser = baseURL + "/api/user/";
  static const String userInfo = baseURL + "/api/user/current_user/";
  static const String sendMessage = baseURL + "/messaging/";
  static const String getMessages = baseURL + "/api/user/messages/";
  static const String delMessage = baseURL + "/api/user/message/delete/";
}
