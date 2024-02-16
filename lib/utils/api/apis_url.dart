class ApiData {
  //All API's call end points
  //Base url
  static const String baseUrl = "http://31.220.84.206:9005";
  //Auth call end points
  static const String login = "$baseUrl/login";
  //Register user
  static const String registerUser = "$baseUrl/register";

  //forgot Password call end points
  static const String forgotPassword = "$baseUrl/forgot_password";
  //verify OTP user
  static const String verifyOtp = "$baseUrl/otp_verification";
  //reset password
  static const String resetPassword = "$baseUrl/set_password";

}
