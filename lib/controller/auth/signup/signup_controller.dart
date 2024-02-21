import 'dart:async';
import 'dart:convert';
import 'package:smarty_social/utils/libraries/app_libraries.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  RxBool isLoading = false.obs;

  //Register user call
  Future<void> registerUser() async {
    try {
      isLoading.value = true;

      Uri url = Uri.parse(ApiData.registerUser);
      if (kDebugMode) {
        print("Register user request------------$url");
      }
      var headers = <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      var body = jsonEncode({
        'user_name': username.text,
        'email': email.text,
        'Password': password.text,
      });

      var res = await http
          .post(
            url,
            headers: headers,
            body: body,
          )
          .timeout(const Duration(seconds: 20));

      print("response of register call==============${res.statusCode}");
      print("response of register call==============${res.body}");

      if (res.statusCode == 200) {
        signUpDialog();
        Future.delayed(const Duration(seconds: 2), () {
          Get.back();
          Get.back(); // Dismiss the dialog
        });
        // Get.back();

        // CommonToast.showToast(AppStrings.registrationSuccess);
        isLoading.value = false;

        update();
      } else if (res.statusCode == 400) {
        CommonToast.showToast(AppStrings.alreadyRegister);

        isLoading.value = false;
        update();
      }
    } on TimeoutException catch (e) {
      // Handle timeout exception
      CommonToast.showToast(AppStrings.somethingWentWrong);

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

  void signUpDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Adjust the border radius as needed
        ),
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
            height: Get.height / 4.8,
            width: Get.width / 1.6,
            child: Column(
              children: [
                CommonSpaces.spaceVertical10,
                Text(
                  'Signup',
                  style: CommonTextStyle.EditProfileFont,
                ),
                CommonSpaces.spaceVertical10,
                Image.asset(
                  AppAssets.signUpdialog,
                  height: 45,
                ),
                CommonSpaces.spaceVertical20,
                Text(
                  'Congratulations!',
                  style: CommonTextStyle.EditProfileFont,
                ),
                CommonSpaces.spaceVertical10,
                Text(
                  'Account has been created successfully',
                  style: CommonTextStyle.font12weightNormal342f,
                ),
              ],
            )),
      ),
    );
  }
}
