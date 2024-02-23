import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart'; // Import the intl package for date formatting
import 'package:smarty_social/utils/libraries/app_libraries.dart';
import 'package:http/http.dart' as http;

import '../../models/posts_model/posts_model.dart';

class ExploreController extends GetxController with InitializeLocalStorage{
  RxBool isLoading = false.obs;
  late Future<List<FeedPostData>?> feedsFuture;
  RxList<bool> likedList = List.generate(500, (index) => false).obs;
  String myUserId="";


  String formattedDate(String timestamp) {
    // Parse the timestamp string into a DateTime object
    DateTime dateTime = DateTime.parse(timestamp);

    // Format the DateTime object to display only the date
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);


    return formattedDate;
  }

  void likeValue(int index) async {
    likedList[index] = !likedList[index];
    update();
  }

  @override
  void onInit() async {
    feedsFuture = getFeeds();
    myUserId=storage.read("userId");
    super.onInit();
  }

  Future<List<FeedPostData>?> getFeeds() async {
    try {
       isLoading.value = true;
       feedsFuture = Future.value([]);

       Uri url = Uri.parse(ApiData.getFeedPost);
      if (kDebugMode) {
        print("Get user request------------$url");
      }
      var res = await http.get(url).timeout(const Duration(seconds: 30));

      print("response of explore call==============${res.statusCode}");
      print("response of explore call==============${res.body}");

      if (res.statusCode == 200) {
        List body = json.decode(res.body);
        body=body.reversed.toList();
        isLoading.value=false;

        return body.map((e) => FeedPostData.fromJson(e)).toList();
      }  else {
        CommonToast.showToast(AppStrings.somethingWentWrong);
        isLoading.value=false;

      }
    } on TimeoutException catch (e) {
      CommonToast.showToast(AppStrings.unableToConnect);
      isLoading.value=false;

      print("Request timed out: $e");
    } on http.ClientException catch (e) {
      CommonToast.showToast(AppStrings.connectionNotStable);
      isLoading.value=false;

      print("Client-side error occurred: $e");
    } catch (e) {
      isLoading.value=false;

      print("Error occurred during request: $e");
    }
    return null;
  }


  Future<void> followUser(String followerId) async {
    try {
      isLoading.value = true;

      Uri url = Uri.parse(ApiData.followUser);
      if (kDebugMode) {
        print("Follow user request------------$url");
      }

      var body = jsonEncode({
        "follower_id": followerId,
        "user_id": myUserId,
      });

      var res = await http
          .post(
        url,
        body: body,
      )
          .timeout(const Duration(seconds: 20));

      print("response of follow==============${res.statusCode}");
      print("response of follow==============$body");
      print("response of follow==============${res.body}");

      if (res.statusCode == 200) {
        var data = json.decode(res.body);

        CommonToast.showToast(AppStrings.loginSuccess);
        isLoading.value = false;


        update();
      }

      else if (res.statusCode == 401) {
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
