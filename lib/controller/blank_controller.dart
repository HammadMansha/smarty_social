import 'package:get/get.dart';

import '../routes/app_routes.dart';

class BlanKScreenController extends GetxController {
  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 1), () {
      Get.toNamed(Routes.splashScreen);
    });
  }
}
