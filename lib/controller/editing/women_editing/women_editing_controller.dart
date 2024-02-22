import 'dart:io';
import 'package:smarty_social/utils/libraries/app_libraries.dart';

class WomenEditingController extends GetxController {
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
