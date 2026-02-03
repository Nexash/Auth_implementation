class ApiEndPoints {
  static const String baseUrl = "http://192.168.3.63:8000/api/auth";
  static const String login = "/login/";
  static const String register = "/register/";
  static const String userData = "/dummy-view/";
  static const String getnewToken =
      "http://192.168.3.63:8000/api/token/refresh/";
  static const String changePassword = "$baseUrl/change-password/";
  static const String resetPassword = "$baseUrl/reset-password/";
}
