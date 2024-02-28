import 'package:smarty_social/widgets/common_button/done_button.dart';
import 'dart:io';
import '../../controller/edit_profile_controller/edit_profile_controller.dart';
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
      return GetBuilder<EditProfileController>(init:EditProfileController() ,builder: (_) {
          return GestureDetector(
            onTap: () {
              if (_.showDialog.value == true) {
                _.showDialog.value = false;
                _.update();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Stack(alignment: Alignment.bottomRight, children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 55,
                      backgroundImage: _.image != null
                             ? FileImage(File(_.image!.path))
                             :  const AssetImage(AppAssets.emptyCircle)  as ImageProvider<Object>,


                   // Placeholder or empty widget when image is null
                      ),
                           InkWell(
                            onTap: () {
                             _.showDialog.value=true;
                             _.update();
                             Future.delayed(const Duration(seconds: 5), () {
                               // if(_.showDialog.value==true){
                               //   print("Box is open");
                               //   Get.back();
                               // }
                               _.showDialog.value=false;
                               _.update();

                             });


                            },
                            child: Image.asset(
                              AppAssets.cameraImage,
                              height: 34,
                            ),
                          ),

                    ]),
                  ),


                  Obx(
                        () => _.showDialog.value==true
                        ? Center(
                          child: Container(
                                                height: 150,
                                                width: Get.width / 1.6,
                                                decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.5), // Set shadow color
                              spreadRadius: 5, // Set spread radius
                              blurRadius: 7, // Set blur radius
                              offset: const Offset(0, 3), // Set offset
                            ),
                          ],
                                                ),
                                                child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                _.openCamera();
                              },
                              child: SizedBox(
                                width: 80,
                                height: 80,
                                child:
                                Image.asset(AppAssets.selectCamera),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await _.getImageFromGallery();
                              },
                              child: SizedBox(
                                width: 80,
                                height: 80,
                                child: Image.asset(
                                    AppAssets.selectGallery),
                              ),
                            )
                          ],
                                                ),
                                              ),
                        ).marginOnly(top: 20)
                        : const SizedBox(),
                  ),

                  CommonSpaces.spaceVertical30,
                  Text(
                    'Username',
                    style: CommonTextStyle.EditProfileFont,
                  ).marginOnly(left: 22),
                  CommonTextField(

                    bordercolor: Colors.black,
                    controller: _.name,
                    disableBorderColor: const Color(0xffC1C1C1),
                  ).marginOnly(left: 20, right: 20),
                  CommonSpaces.spaceVertical30,
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
                  CommonSpaces.spaceVertical30,
                  // Text(
                  //   'Gender',
                  //   style: CommonTextStyle.EditProfileFont,
                  // ).marginOnly(left: 22),
                  // CommonTextField(
                  //         bordercolor: Colors.black,
                  //         disableBorderColor: const Color(0xffC1C1C1),
                  //         controller: _.gender)
                  //     .marginOnly(left: 20, right: 20),
                  CommonSpaces.spaceVertical20,
                  Text(
                    'Date Of Birth',
                    style: CommonTextStyle.EditProfileFont,
                  ).marginOnly(left: 22),
                  CommonTextField(
                    keyboardType: TextInputType.number,
                          hintText: 'DD-MM-YYYY',
                          hintTextColor: const Color(0xffC1C1C1),
                          bordercolor: Colors.black,
                          disableBorderColor: const Color(0xffC1C1C1),
                          controller: _.dateOfBirth)
                      .marginOnly(left: 20, right: 20),
                ],
              ),
            ),
          );
        }
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
                    _.openCamera();
                  },
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.asset(AppAssets.selectCamera),
                  ),
                ).marginOnly(left: 50),
                InkWell(
                  onTap: () async {
                    await _.getImageFromGallery();
                  },
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.asset(AppAssets.selectGallery),
                  ),
                ).marginOnly(right: 50)
              ],
            ),
          )),
    );
  }

}
