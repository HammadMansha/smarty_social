import 'package:smarty_social/view/editing/women_editing/women_editing_post.dart';

import '../utils/libraries/app_libraries.dart';

class AppPages {
  static var initial = Routes.createPostScreen;

  static final routes = [
    //Splash screen
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
    ),

    //Login screen
    GetPage(
      name: Routes.loginScreen,
      page: () => LoginScreen(),
    ),

    //Sign up screen
    GetPage(
      name: Routes.signUpScreen,
      page: () => SignUpScreen(),
    ),

    //Forgot Password screen
    GetPage(
      name: Routes.forgotPasswordScreen,
      page: () => ForgotPassword(),
    ),

    //Verify Email screen
    GetPage(
      name: Routes.emailVerificationScreen,
      page: () => EmailVerify(),
    ),

    //Reset Password screen
    GetPage(
      name: Routes.resetPasswordScreen,
      page: () => ResetPassword(),
    ),

    //Reset Password screen
    GetPage(
      name: Routes.successReset,
      page: () => const ResetPasswordSuccess(),
    ),

    //Reset Password screen
    GetPage(
      name: Routes.dashboardScreen,
      page: () => const DashboardScreen(),
    ),

    //create post screen
    GetPage(
      name: Routes.createPostScreen,
      page: () => const CreatePostScreen(),
    ),

    //Edit post screen
    GetPage(
      name: Routes.menEditPostScreen,
      page: () => const MenEditingPostScreen(),
    ),

    //Women cloth editing
    GetPage(
      name: Routes.womenEditPostScreen,
      page: () => const WomenEditingPostScreen(),
    ),
  ];
}
