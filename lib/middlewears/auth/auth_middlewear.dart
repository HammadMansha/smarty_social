import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarty_social/routes/app_routes.dart';

import '../../services/auth_service/auth_services.dart';
import '../../utils/libraries/app_libraries.dart';

class AuthMiddleware extends GetMiddleware {
  final GetStorage storage = GetStorage();
  AuthService authService = Get.find<AuthService>();
  @override
  RouteSettings? redirect(String? route) {
    print('value>>>>>>>>>>>>>>>1${storage.read("isAppOpen")}');
    print("I am in auth middlewear==================");
    return storage.hasData("isAppOpen") == true
        ? null
        : const RouteSettings(name: Routes.blankScreen);
  }
}
