import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarty_social/routes/app_routes.dart';

import '../../services/auth_service/auth_services.dart';

class AuthMiddleware extends GetMiddleware {
  AuthService authService = Get.find<AuthService>();
  @override
  RouteSettings? redirect(String? route) {
    print("I am in auth middlewear==================");
    return authService.loggedInUser
        ? null
        : const RouteSettings(name: Routes.blankScreen);
  }
}
