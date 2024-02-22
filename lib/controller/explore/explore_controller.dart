import 'dart:async';
import 'dart:convert';
import 'package:smarty_social/utils/libraries/app_libraries.dart';
import 'package:http/http.dart' as http;

class FeedController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> getFeeds() async {
    try {
      isLoading.value = true;

      Uri url = Uri.parse(ApiData.getFeedPost);
      if (kDebugMode) {
        print("Get user request------------$url");
      }

      var res = await http
          .get(
            url,
          )
          .timeout(const Duration(seconds: 20));

      print("response of explore call==============${res.statusCode}");
      print("response of explore call==============${res.body}");

      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        isLoading.value = false;
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
