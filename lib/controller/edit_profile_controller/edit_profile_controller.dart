import 'dart:io';

import '../../utils/libraries/app_libraries.dart';

class EditProfileController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  CreatePostController controller = Get.put(CreatePostController());
  RxBool showDialog=false.obs;

  File? image;
  final picker = ImagePicker();


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
      showDialog.value=false;

      update();

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


  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      image = File(
        pickedFile.path,
      ); // Assigning a File object to _image

      showDialog.value=false;
      update();
    }
  }


}
