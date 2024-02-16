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
                  },
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.asset(AppAssets.women),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.genderSelect.value = "men";
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
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.genderSelect.value = "";
                },
                child: Container(
                  width: Get.width,
                  color: AppColors.colorF7F7,
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height / 7,
                      ),
                      Obx(
                        () => controller.genderSelect.value.isNotEmpty
                            ? Container(
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
                                      onTap: () {},
                                      child: SizedBox(
                                        width: 80,
                                        height: 80,
                                        child:
                                            Image.asset(AppAssets.selectCamera),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await controller.getImageFromGallery();
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
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
