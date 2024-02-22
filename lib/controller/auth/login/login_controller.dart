import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../utils/libraries/app_libraries.dart';

class LoginController extends GetxController with InitializeLocalStorage {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool rememberMe = false.obs;
  RxBool isLoading = false.obs;
  RxBool secureText = true.obs;

  Future<void> loginUser() async {
    try {
      isLoading.value = true;

      Uri url = Uri.parse(ApiData.login);
      if (kDebugMode) {
        print("Login user request------------$url");
      }
      var headers = <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      var body = jsonEncode({
        "user_name": email.text,
        "Password": password.text,
      });

      var res = await http
          .post(
            url,
            headers: headers,
            body: body,
          )
          .timeout(const Duration(seconds: 20));

      print("response of login call==============${res.statusCode}");
      print("response of login call==============${res.body}");

      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        storage.write("userId", data["User_id"]);
        storage.write("token", data["Session_token"]);
        storage.write("userEmail",data["Email"]);
        storage.write("username",data["Username"]);

        if (rememberMe.value == true) {
          await storage.write("isAppOpen", 'true');
        }

        CommonToast.showToast(AppStrings.loginSuccess);
        isLoading.value = false;

        Get.offAll(() =>  DashboardScreen());

        update();
      } else if (res.statusCode == 401) {
        CommonToast.showToast(AppStrings.incorrectCredentials);

        isLoading.value = false;
        update();
      } else {
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
