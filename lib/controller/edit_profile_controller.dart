import '../utils/libraries/app_libraries.dart';

class EditProfileController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();

  CreatePostController controller = Get.put(CreatePostController());
}
