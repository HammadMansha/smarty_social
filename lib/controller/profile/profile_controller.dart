import 'dart:async';
import 'dart:convert';

import '../../utils/libraries/app_libraries.dart';
import 'package:http/http.dart' as http;

class ProfileScreenController extends GetxController
    with InitializeLocalStorage {
  final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();

  RxBool isLoading = false.obs;
  String myUserId = "";
  RxInt followers = 0.obs;
  RxInt following = 0.obs;
  RxInt posts = 0.obs;
  RxList myPosts = [].obs;
  String username = "";

  @override
  void onInit() async {
    if (storage.hasData("userId")) {
      myUserId = storage.read("userId");
      username = storage.read("username");

      await getUserFollowers(myUserId);
      await getUserFollowing(myUserId);
      await getMyPosts(myUserId);
    }



    super.onInit();
  }

//user followers
  Future<void> getUserFollowers(String userId) async {
    try {
      isLoading.value = true;
      Uri url = Uri.parse("${ApiData.getUsersFollow}/$userId");
      if (kDebugMode) {
        print("Get user followers request------------$url");
      }
      var res = await http.get(url).timeout(const Duration(seconds: 30));

      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        followers.value = data["followers_count"];
        print("===============follower==============$followers");

        isLoading.value = false;
      } else {
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

  //user following
  Future<void> getUserFollowing(String userId) async {
    try {
      isLoading.value = true;

      Uri url = Uri.parse("${ApiData.getUsersFollowing}/$userId");
      if (kDebugMode) {
        print("Get user followers request------------$url");
      }
      var res = await http.get(url).timeout(const Duration(seconds: 30));

      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        following.value = data["following_count"];
        isLoading.value = false;

        print("===============follower==============$followers");
      } else {
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

  //user post
  Future<void> getMyPosts(String userId) async {
    try {
      isLoading.value = true;

      Uri url = Uri.parse("${ApiData.getMyPosts}/$userId");
      if (kDebugMode) {
        print("Get user posts request------------$url");
      }
      var res = await http.get(url).timeout(const Duration(seconds: 30));

      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        myPosts.addAll(data);
        isLoading.value = false;

        print("===============Posts==============$data");
      } else {
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
    return;
  }
}
