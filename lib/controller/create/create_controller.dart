import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:smarty_social/utils/libraries/app_libraries.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class CreatePostController extends GetxController {
  late bool arePermissionsGranted;

  File? image;
  final picker = ImagePicker();
  RxString genderSelect = "".obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await askForPermissions();
  }

  // Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      image = File(
        pickedFile.path,
      ); // Assigning a File object to _image

      if (genderSelect.value == "women") {
        Get.toNamed(Routes.womenEditPostScreen);
      } else {
        Get.toNamed(Routes.menEditPostScreen);
      }
    }
  }

  Future<bool> checkPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.status;
    PermissionStatus storageStatus = await Permission.storage.status;
    update();

    return cameraStatus == PermissionStatus.granted &&
        storageStatus == PermissionStatus.granted;
  }

  Future<void> requestPermissions() async {
    await Permission.camera.request();
    await Permission.storage.request();
    update();
  }

  Future<void> askForPermissions() async {
    arePermissionsGranted = await checkPermissions();
    update();
    print("========================$arePermissionsGranted");
    if (!arePermissionsGranted) {
      await requestPermissions();
      update();
    }
    update();
  }

  Future<void> openCamera() async {
    print('hello g///////////');
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedImage != null) {
      // Save the image to the gallery
      // final result = await ImageGallerySaver.saveFile(pickedImage.path);

      image = File(
        pickedImage.path,
      ); // Assigning a File object to _image

      if (genderSelect.value == "women") {
        Get.toNamed(Routes.womenEditPostScreen);
      } else {
        Get.toNamed(Routes.menEditPostScreen);
      }

      // Check if the image was saved successfully
      // if (result['isSuccess']) {
      //   // Do something with the image
      //   print('Image captured and saved to gallery: ${pickedImage.path}');
      // } else {
      //   // Handle error
      //   print('Failed to save image: ${result['errorMessage']}');
      // }
    } else {
      // No image captured
      print('No image captured');
    }
  }
}
