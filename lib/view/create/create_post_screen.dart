import 'package:smarty_social/utils/libraries/app_libraries.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: bodyData(),
    );
  }

  bodyData() {
    CreatePostController controller = Get.put(CreatePostController());
    return SafeArea(
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Smarty Social',
                  style: TextStyle(
                      fontFamily: 'BirdsOfParadise',
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 25,
                  width: 25,
                  child: Image.asset(AppAssets.crown),
                ),
              ],
            ).marginSymmetric(horizontal: 20, vertical: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    controller.genderSelect.value = "women";
                    openGalleryDialog(controller);
                    Future.delayed(
                      const Duration(seconds: 3),
                      () {
                        Get.back();
                      },
                    );
                  },
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.asset(AppAssets.women),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    controller.genderSelect.value = "men";
                    openGalleryDialog(controller);
                    Future.delayed(
                      const Duration(seconds: 3),
                      () {
                        Get.back();
                      },
                    );
                  },
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.asset(AppAssets.men),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.asset(AppAssets.storyMaker),
                  ),
                ),
              ],
            ).marginOnly(left: 30, right: 30, top: 25, bottom: 10),
          ],
        ),
      ),
    );
  }
}

void openGalleryDialog(CreatePostController _) {
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
