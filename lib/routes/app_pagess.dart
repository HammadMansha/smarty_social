import 'package:smarty_social/view/editing/women_editing/women_editing_post.dart';

import '../middlewears/auth/auth_middlewear.dart';
import '../utils/libraries/app_libraries.dart';
import '../view/blank_screen.dart';
import '../view/edit_profile/edit_profile_screen.dart';

class AppPages {
  static var initial = Routes.dashboardScreen;

  static final routes = [
    //Splash screen
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.blankScreen,
      page: () => const BlankScreen(),
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
      page: () => DashboardScreen(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),

    //create post screen
    GetPage(
      name: Routes.createPostScreen,
      page: () =>  CreatePostScreen(),
    ),

    //profile page screen

    GetPage(
      name: Routes.profileScreen,
      page: () => ProfileScreen(),
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

    //Edit profile screen

    GetPage(
      name: Routes.editProfileScreen,
      page: () => const EditProfileScreen(),
    ),
  ];
}
