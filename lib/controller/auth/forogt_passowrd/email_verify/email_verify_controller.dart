import 'dart:async';
import 'dart:convert';
import 'dart:math';

import '../../../../utils/libraries/app_libraries.dart';
import 'package:http/http.dart'as http;

import '../forgot_password_controller.dart';

class EmailVerificationController extends GetxController{
  TextEditingController pin=TextEditingController();
  ForgotPasswordController forgotPasswordController = Get.find<ForgotPasswordController>();

   final formKey = GlobalKey<FormState>();
  RxBool isEmpty = true.obs;
  RxBool isLoading=false.obs;



  Future<void> verifyOtp() async {
    print("================================${pin.text}");
    isLoading.value = true;
    update();

    try {

      Uri url = Uri.parse(ApiData.verifyOtp);
      if (kDebugMode) {
        print("verify otp user request------------$url");
      }
      var headers = <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      var body = jsonEncode(
          {
            "user_name":Get.arguments["email"],
            "otp": pin.text
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
        CommonToast.showToast(AppStrings.otpVerified);
        isLoading.value = false;
        String temp=pin.text;
        pin=TextEditingController(text: temp);
        update();
        Get.to(()=> ResetPassword(),arguments:{
          "email":Get.arguments["email"],
        });
      } else if (res.statusCode == 401) {
        CommonToast.showToast(AppStrings.invalidOtpVerified);
        isLoading.value = false;
        String temp=pin.text;
        pin=TextEditingController(text: temp);
        update();
      }
      else if (res.statusCode == 404) {
        CommonToast.showToast(AppStrings.noRecordFound);
        isLoading.value = false;
        String temp=pin.text;
        pin=TextEditingController(text: temp);
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