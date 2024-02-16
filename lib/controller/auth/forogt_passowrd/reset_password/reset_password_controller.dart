
import 'dart:async';
import 'dart:convert';

import '../../../../utils/libraries/app_libraries.dart';
import 'package:http/http.dart' as http;

class ResetPasswordController extends GetxController{

  TextEditingController password=TextEditingController();
  TextEditingController confirmPassword=TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> resetPassword() async {
    print("================================${password.text}");
    isLoading.value = true;
    update();

    try {

      Uri url = Uri.parse(ApiData.resetPassword);
      if (kDebugMode) {
        print("reset password request------------$url");
      }
      var headers = <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      var body = jsonEncode(
          {
            "user_name": Get.arguments["email"].toString(),
            "Password": password.text,
          }
      );

      print("body-----------------$body");

      var res = await http.post(
        url,
        headers: headers,
        body: body,
      ).timeout(const Duration(seconds: 20));

      print("response of verify code==============${res.statusCode}");
      print("response of verify code==============${res.body}");

      if (res.statusCode == 200) {
        CommonToast.showToast(AppStrings.passwordChangeSuccess);
        isLoading.value = false;
        Get.to(()=> const ResetPasswordSuccess());
      }
    } on TimeoutException catch (e) {
      // Handle timeout exception
      CommonToast.showToast(AppStrings.unableToConnect);
      isLoading.value = false;
      update();
      print("Request timed out: $e");
    } on http.ClientException catch (e) {
      CommonToast.showToast(AppStrings.connectionNotStable);
      // Handle client-side exceptions (e.g., internet connection issues)
      print("Client-side error occurred: $e");
      isLoading.value = false;
      update();
    } catch (e) {
      print("Error occurred during request: $e");
      isLoading.value = false;
      update();
    }
  }




}