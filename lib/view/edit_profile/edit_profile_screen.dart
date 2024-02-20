import 'package:smarty_social/widgets/common_button/done_button.dart';
import 'dart:io';
import '../../controller/edit_profile_controller.dart';
import '../../utils/libraries/app_libraries.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Edit Profile",
          style: CommonTextStyle.font16weight400BlackNexRegular,
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            size: 20,
            color: AppColors.blackColor,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              // Get.toNamed(Routes.menClothEditing);
            },
            child: const SizedBox(
              child: DoneButton(
                text: 'Done',
              ),
            ),
          ).marginOnly(right: 20),
        ],
      ),
      body: bodyData(context),
    );
  }

  Widget bodyData(
    BuildContext context,
  ) {
    EditProfileController _ = Get.put(EditProfileController());
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Stack(alignment: Alignment.bottomRight, children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 55,
                child: _.controller.image != null
                    ? ClipOval(
                        child: Image.file(
                          _.controller.image as File,
                          fit: BoxFit.scaleDown,
                        ),
                      )
                    : const SizedBox(), // Placeholder or empty widget when image is null
              ),
              InkWell(
                onTap: () {
                  openGalleryDialog(_);
                },
                child: Image.asset(
                  AppAssets.cameraImage,
                  height: 34,
                ),
              ),
            ]),
          ),
          CommonSpaces.spaceVertical30,
          Text(
            'Name',
            style: CommonTextStyle.EditProfileFont,
          ).marginOnly(left: 22),
          CommonTextField(
            bordercolor: Colors.black,
            controller: _.name,
            disableBorderColor: const Color(0xffC1C1C1),
          ).marginOnly(left: 20, right: 20),
          CommonSpaces.spaceVertical20,
          Text(
            'Bio',
            style: CommonTextStyle.EditProfileFont,
          ).marginOnly(left: 22),
          CommonTextField(
            bordercolor: Colors.black,
            disableBorderColor: const Color(0xffC1C1C1),
            controller: _.bio,
            maxLine: 4,
          ).marginOnly(left: 20, right: 20),
          CommonSpaces.spaceVertical20,
          Text(
            'Gender',
            style: CommonTextStyle.EditProfileFont,
          ).marginOnly(left: 22),
          CommonTextField(
                  bordercolor: Colors.black,
                  disableBorderColor: const Color(0xffC1C1C1),
                  controller: _.gender)
              .marginOnly(left: 20, right: 20),
          CommonSpaces.spaceVertical20,
          Text(
            'Date Of Birth',
            style: CommonTextStyle.EditProfileFont,
          ).marginOnly(left: 22),
          CommonTextField(
                  hintText: 'DD/MM/YYYY',
                  hintTextColor: const Color(0xffC1C1C1),
                  bordercolor: Colors.black,
                  disableBorderColor: const Color(0xffC1C1C1),
                  controller: _.dateOfBirth)
              .marginOnly(left: 20, right: 20),
        ],
      ),
    );
  }

  void openGalleryDialog(EditProfileController _) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Adjust the border radius as needed
        ),
        contentPadding: EdgeInsets.zero,
        content: Container(
          height: 150,
          width: Get.width / 1.6,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Set shadow color
                spreadRadius: 5, // Set spread radius
                blurRadius: 7, // Set blur radius
                offset: const Offset(0, 3), // Set offset
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  _.controller.openCamera();
                },
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.asset(AppAssets.selectCamera),
                ),
              ).marginOnly(left: 20),
              InkWell(
                onTap: () async {
                  await _.controller.getImageFromGallery();
                },
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.asset(AppAssets.selectGallery),
                ),
              ).marginOnly(right: 20)
            ],
          ),
        ),
      ),
    );
  }
}
