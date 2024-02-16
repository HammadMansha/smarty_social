
import 'dart:async';
import 'dart:convert';

import '../../../utils/libraries/app_libraries.dart';
import 'package:http/http.dart'as http;

class ForgotPasswordController extends GetxController{

  TextEditingController email=TextEditingController();
  RxBool isLoading=false.obs;


  Future<void> forgotPassword() async {
    try {
      isLoading.value = true;

      Uri url = Uri.parse(ApiData.forgotPassword);
      if (kDebugMode) {
        print("forgot password user request------------$url");
      }
      var headers = <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      var body = jsonEncode(
          {
            "username_or_email":email.text,
          }
      );

      var res = await http
          .post(
        url,
        headers: headers,
        body: body,
      )
          .timeout(const Duration(seconds: 15));

      print("response of forgot call==============${res.statusCode}");
      print("response of forgot call==============${res.body}");

      if (res.statusCode == 200) {
        CommonToast.showToast(AppStrings.checkEmailForOtp);
        isLoading.value = false;
        Get.toNamed(Routes.emailVerificationScreen,arguments: {"email":email.text});
        email.clear();

      } else if (res.statusCode == 500) {
        CommonToast.showToast(AppStrings.invalidEmailOrUsername);
        isLoading.value = false;
        update();
      }
      else{
        CommonToast.showToast(AppStrings.somethingWentWrong);
        isLoading.value = false;
        update();
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