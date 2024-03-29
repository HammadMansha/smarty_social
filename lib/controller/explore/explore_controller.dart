import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart'; // Import the intl package for date formatting
import 'package:smarty_social/utils/libraries/app_libraries.dart';
import 'package:http/http.dart' as http;

import '../../mixin_classes/check_internet_connectivity.dart';
import '../../models/posts_model/posts_model.dart';
import '../profile/profile_controller.dart';

class ExploreController extends GetxController with InitializeLocalStorage {
  RxBool isLoading = false.obs;
  late Future<List<FeedPostData>?> feedsFuture;

  RxList<bool> likedList = List.generate(500, (index) => false).obs;
  String myUserId = "";
  RxList following = [].obs;
  RxBool isFollowing = false.obs;
  RxBool isFollow = false.obs;
  ProfileScreenController profileScreenController =
      Get.put(ProfileScreenController());
  bool connected = true;
  bool wifiConnected = true;
  bool mobileConnected = true;

  @override
  void onInit() async {
    // connected = await ConnectivityHelper.isConnected();
    // wifiConnected = await ConnectivityHelper.isWifiConnected();
    // mobileConnected = await ConnectivityHelper.isMobileConnected();
    print('connet>>>>>> ${connected}');
    if (connected || wifiConnected || mobileConnected == true) {
      feedsFuture = getFeeds();
    }

    if (storage.hasData("userId") == true) {
      myUserId = storage.read("userId");
      await getUserFollowing(myUserId);
      update();
    }

    super.onInit();
  }

  String formattedDate(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);

    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    return formattedDate;
  }

  void likeValue(int index) async {
    likedList[index] = !likedList[index];
    update();
  }

  Future<List<FeedPostData>?> getFeeds() async {
    try {
      isLoading.value = true;
      feedsFuture = Future.value([]);

      Uri url = Uri.parse(ApiData.getFeedPost);
      if (kDebugMode) {
        print("Get user request------------$url");
      }
      var res = await http.get(url).timeout(const Duration(seconds: 20));

      print("response of explore call==============${res.statusCode}");
      print("response of explore call==============${res.body}");

      if (res.statusCode == 200) {
        List body = json.decode(res.body);
        body = body.reversed.toList();
        isLoading.value = false;

        return body.map((e) => FeedPostData.fromJson(e)).toList();
      } else {
        print("Skip else");
        CommonToast.showToast(AppStrings.somethingWentWrong);
        isLoading.value = false;
      }
    } on TimeoutException catch (e) {
      CommonToast.showToast(AppStrings.unableToConnect);
      isLoading.value = false;

      print("Request timed out: $e");
    } on http.ClientException catch (e) {
      CommonToast.showToast(AppStrings.connectionNotStable);
      isLoading.value = false;

      print("Client-side error occurred: $e");
    } catch (e) {
      isLoading.value = false;

      print("Error occurred during request: $e");
    }
    return null;
  }

  //follow user
  Future<void> followUser(String followerId) async {
    try {
      Uri url = Uri.parse(ApiData.followUser);
      if (kDebugMode) {
        print("Follow user request------------$url");
      }

      var body = jsonEncode({
        "follower_id": followerId,
        "user_id": myUserId,
      });

      var headers = <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      var res = await http
          .post(
            url,
            body: body,
            headers: headers,
          )
          .timeout(const Duration(seconds: 20));

      print("response of follow==============${res.statusCode}");
      print("response of follow==============$body");
      print("response of follow==============${res.body}");
      print("Response Headers: ${res.headers}");

      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        isFollowing.value = true;

        profileScreenController.followers.value;
        profileScreenController.update();
        profileScreenController.following.value;
        profileScreenController.update();
        getUserFollowing(myUserId);
        // await pullRefresh();
        isLoading.value = false;

        update();

        update();
      } else if (res.statusCode == 307) {
        // Extract the redirect URL from the response headers
        var redirectUrl = res.headers['location'];

        if (redirectUrl != null && redirectUrl.isNotEmpty) {
          // Make another request to the redirect URL
          var redirectRes = await http.post(
            Uri.parse(redirectUrl),
            body: body,
            headers: headers,
          );

          isFollowing.value = true;
          isLoading.value = false;

          // Process the response as needed
          print("Redirected response: ${redirectRes.statusCode}");
          print("Redirected response body: ${redirectRes.body}");
        } else {
          isLoading.value = false;

          // No redirect URL provided, handle the response as usual
          print("Response: ${res.statusCode}");
          print("Response body: ${res.body}");

          // Handle the response status code and body here
        }
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

  //unfollow user
  Future<void> unFollowUser(String followerId) async {
    try {
      Uri url = Uri.parse(ApiData.unFollowUSer);
      if (kDebugMode) {
        print("unfollow user request------------$url");
      }

      var body = jsonEncode({
        "follower_id": followerId,
        "user_id": myUserId,
      });

      var headers = <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      var res = await http
          .post(
            url,
            body: body,
            headers: headers,
          )
          .timeout(const Duration(seconds: 20));

      print("response of unfollow==============${res.statusCode}");
      print("response of unfollow==============$body");
      print("response of unfollow==============${res.body}");
      print("Response Headers: ${res.headers}");

      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        profileScreenController.followers.value;
        profileScreenController.update();

        profileScreenController.following.value;
        profileScreenController.update();

        isLoading.value = false;

        update();
      } else if (res.statusCode == 307) {
        // Extract the redirect URL from the response headers
        var redirectUrl = res.headers['location'];

        if (redirectUrl != null && redirectUrl.isNotEmpty) {
          // Make another request to the redirect URL
          var redirectRes = await http.post(
            Uri.parse(redirectUrl),
            body: body,
            headers: headers,
          );

          await getUserFollowing(myUserId);

          isLoading.value = false;

          // Process the response as needed
          print("Redirected response unfollow: ${redirectRes.statusCode}");
          print("Redirected response body: ${redirectRes.body}");
        } else {
          isLoading.value = false;

          // No redirect URL provided, handle the response as usual
          print("Response: ${res.statusCode}");
          print("Response body: ${res.body}");

          // Handle the response status code and body here
        }
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

  Future<void> getUserFollowing(String userId) async {
    try {
      Uri url = Uri.parse("${ApiData.userFollowingList}/$userId");
      var res = await http.get(url).timeout(const Duration(seconds: 30));

      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        following.assignAll(data);
        update(); // Populate the following list
        isLoading.value = false;
      } else {
        print("Skip else");

        CommonToast.showToast(AppStrings.somethingWentWrong);
        isLoading.value = false;
      }
    } on TimeoutException catch (e) {
      CommonToast.showToast(AppStrings.unableToConnect);
      isLoading.value = false;
      print("Request timed out: $e");
    } on http.ClientException catch (e) {
      CommonToast.showToast(AppStrings.connectionNotStable);
      isLoading.value = false;
      print("Client-side error occurred: $e");
    } catch (e) {
      isLoading.value = false;
      print("Error occurred during request: $e");
    }
  }

  Future<void> pullRefresh() async {
    print('helllllllllllll0');

    feedsFuture = getFeeds();
    getUserFollowing(storage.read("userId"));
    // CommonToast.getToast('Wait, data fetching...');
  }
}
