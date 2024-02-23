import 'package:flutter/material.dart';
import '../../services/auth_service/auth_services.dart';
import '../../utils/libraries/app_libraries.dart';


class SplashScreenController extends GetxController{

  final storage=GetStorage();


  @override
  void onInit() {
    storage.erase();
    // TODO: implement onInit
    super.onInit();
  }

}