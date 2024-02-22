import 'dart:io';
import 'package:smarty_social/utils/libraries/app_libraries.dart';
import 'package:http/http.dart' as http;

class WomenEditingController extends GetxController
    with InitializeLocalStorage {
  double rotationAngle = 0.0;
  bool mirror = false;
  late double aspectRatio; // Variable to store the aspect ratio for cropping
  CreatePostController createPostController = Get.find<CreatePostController>();

  File? croppedImagePath;
  RxBool framingDone = false.obs;

  String selectedNav = "";

  List<String> womenAssetType = [
    "Suits",
    "Weeding Outfits",
    "Skirts",
    "Sarrees"
  ];
  String selectedAsset = "Suits";
  RxBool isLoading = false.obs;

  /////////// Bottom Navigation Bar
  int selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> uploadImageToDb() async {
    try {
      isLoading.value = true;
      update();
      var url = Uri.parse(ApiData.uploadImageForFeed);
      if (kDebugMode) {
        print("Complete request------------$url");
        print("user id request------------${storage.read("userId")}");
        print("user id request------------${storage.read("username")}");
      }

      var request = http.MultipartRequest('POST', url);
      // Add the image file to the request
      var imagePath = await http.MultipartFile.fromPath(
          'file', createPostController.image!.path.toString());

      print("user image request------------${imagePath.length}");

      request.files.add(imagePath);
      request.fields['user_id'] = storage.read("userId").toString();
      request.fields['username'] = storage.read("username").toString();

      var response = await request.send();

      if (response.statusCode == 200) {
        // API call was successful
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        // Process the response data
        if (kDebugMode) {
          print("Upload API response $responseString");
        }

        Get.offAll(()=>DashboardScreen());
        isLoading.value = false;
        update();
      }
      else if (response.statusCode == 307) {
        // The server is redirecting, get the redirect URL from the response
        var redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          // Create a new MultipartFile object for the redirect request
          var redirectImagePath = await http.MultipartFile.fromPath(
              'file', createPostController.image!.path.toString());

          // Make a new request to the redirect URL
          var redirectRequest = http.MultipartRequest('POST', Uri.parse(redirectUrl));
          redirectRequest.files.add(redirectImagePath);
          redirectRequest.fields['user_id'] = storage.read("userId").toString();
          redirectRequest.fields['username'] = storage.read("username").toString();

          var redirectResponse = await redirectRequest.send();
          if (redirectResponse.statusCode == 200) {
            // Handle the successful response
            var responseData = await redirectResponse.stream.toBytes();
            var responseString = String.fromCharCodes(responseData);
            if (kDebugMode) {
              print("Upload API response $responseString");
            }
            Get.offAll(()=>DashboardScreen());

            isLoading.value = false;
            update();
          } else {
            // Handle other status codes from the redirect response
            print("Redirected request failed with status code: ${redirectResponse.statusCode}");
            isLoading.value = false;
            update();
            CommonToast.showToast(AppStrings.somethingWentWrong);
          }
        } else {
          // Handle case where no redirect URL is provided
          print("Redirect location is missing in the response headers");
          isLoading.value = false;
          update();
          CommonToast.showToast(AppStrings.somethingWentWrong);
        }
      }



      else{
        print("========================Status code===============${response.statusCode}");
        isLoading.value = false;
        update();
        CommonToast.showToast(AppStrings.somethingWentWrong);
      }
    } on SocketException catch (e) {
      print("error in socket exception $e");

      CommonToast.showToast(AppStrings.unableToConnect);

      isLoading.value = false;
      update();
    } catch (e) {
      if (kDebugMode) {
        print("error in catch");
        print("error $e");
      }
      isLoading.value = false;
      update();
    }
  }

  Future<File?> cropImage({required File? imageFile}) async {
    print('heeeeeeeelooo');
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      uiSettings: [
        AndroidUiSettings(
          showCropGrid: false,
          cropFrameColor: Colors.white,
          backgroundColor: Colors.white70,
          toolbarTitle: 'Framing',
          toolbarColor: Colors.white,
          toolbarWidgetColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          activeControlsWidgetColor: Colors.black,
        ),
      ],
      sourcePath: createPostController.image!.path,
    );
    if (croppedImage == null) {
      return imageFile;
    }
    print("Croped image path is=============${croppedImage.path}");
    return File(croppedImage.path);
  }

  void toggleMirror() {
    mirror = !mirror;
    update(); // Update the UI to reflect the new mirror state
  }

  void rotateImage() {
    rotationAngle += 90.0;
    update(); // Update the UI to reflect the new rotation angle
  }

  // Function to set the aspect ratio for cropping
  void setCropAspect(double ratio) {
    aspectRatio = ratio;
    update(); // Update the UI to reflect the new aspect ratio
  }
}
