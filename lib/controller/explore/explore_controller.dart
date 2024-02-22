import 'dart:async';
import 'dart:convert';
import 'package:smarty_social/utils/libraries/app_libraries.dart';
import 'package:http/http.dart' as http;

import '../../models/posts_model/posts_model.dart';

class ExploreController extends GetxController {
  RxBool isLoading = false.obs;
  late Future<List<FeedPostData>?> feedsFuture;
  RxList<bool> likedList = List.generate(500, (index) => false).obs;

  void likeValue(int index) async {
    likedList[index] = !likedList[index];
    update();
  }

  @override
  void onInit() async {
    feedsFuture = getFeeds();
    super.onInit();
  }

  Future<List<FeedPostData>?> getFeeds() async {
    try {
      // isLoading.value = true;
      Uri url = Uri.parse(ApiData.getFeedPost);
      if (kDebugMode) {
        print("Get user request------------$url");
      }
      var res = await http.get(url).timeout(const Duration(seconds: 30));

      print("response of explore call==============${res.statusCode}");
      print("response of explore call==============${res.body}");

      if (res.statusCode == 200) {
        final List body = json.decode(res.body);
        return body.map((e) => FeedPostData.fromJson(e)).toList();
      } else if (res.statusCode == 401) {
        CommonToast.showToast(AppStrings.incorrectCredentials);
      } else {
        CommonToast.showToast(AppStrings.somethingWentWrong);
      }
    } on TimeoutException catch (e) {
      CommonToast.showToast(AppStrings.unableToConnect);
      print("Request timed out: $e");
    } on http.ClientException catch (e) {
      CommonToast.showToast(AppStrings.connectionNotStable);
      print("Client-side error occurred: $e");
    } catch (e) {
      print("Error occurred during request: $e");
    }
    return null;
  }
}
