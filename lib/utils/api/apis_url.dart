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

  //reset password
  static const String logout = "$baseUrl/logout";

//upload images
  static const String uploadImageForFeed = "$baseUrl/upload";

  //get posts
  static const String getFeedPost = "$baseUrl/posts";

  //follow user
  static const String followUser = "$baseUrl/follow";


  //unfollow user
  static const String unFollowUSer = "$baseUrl/unfollow";

  //get followers
  static const String getUsersFollow= "$baseUrl/followers";


  //get following
  static const String getUsersFollowing= "$baseUrl/following";



  //get user posts
  static const String getMyPosts= "$baseUrl/user_posts";



  //get user following list
  static const String userFollowingList= "$baseUrl/user_following";



}
