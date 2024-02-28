import 'package:smarty_social/utils/libraries/app_libraries.dart';

class CreatePostScreen extends StatelessWidget with InitializeLocalStorage{
   CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardScreenController dashboardScreenController=Get.find<DashboardScreenController>();

    return CommonScaffold(
      drawer:  Drawer(
        width: Get.width / 1.4,
        backgroundColor: AppColors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: Get.height/4,
              width: Get.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.drawerImg,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            CommonSpaces.spaceVertical50,
            Row(
              children: [
                Image.asset(
                  AppAssets.kingIcon2,
                  height: 23,
                  width: 29,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  'Get Premium',
                  style: CommonTextStyle.drawerFont,
                )
              ],
            ).marginOnly(left: 15),
            CommonSpaces.spaceVertical20,
            Row(
              children: [
                Image.asset(
                  AppAssets.howtouse,
                  height: 23,
                  width: 29,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  'How to Use',
                  style: CommonTextStyle.drawerFont,
                )
              ],
            ).marginOnly(left: 15),
            CommonSpaces.spaceVertical20,

            //////////Account privacy//////////
            Row(
              children: [
                Image.asset(
                  AppAssets.privacyIcon,
                  height: 23,
                  width: 29,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  'Account Privacy',
                  style: CommonTextStyle.drawerFont,
                )
              ],
            ).marginOnly(left: 15),
            CommonSpaces.spaceVertical20,
            ////////////Share /////////
            Row(
              children: [
                Image.asset(
                  AppAssets.shareIcon,
                  height: 23,
                  width: 29,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  'Share',
                  style: CommonTextStyle.drawerFont,
                )
              ],
            ).marginOnly(left: 15),
            CommonSpaces.spaceVertical20,

            ////////////Languages /////////
            Row(
              children: [
                Image.asset(
                  AppAssets.languagesIcon,
                  height: 23,
                  width: 29,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  'Languages',
                  style: CommonTextStyle.drawerFont,
                )
              ],
            ).marginOnly(left: 15),
            CommonSpaces.spaceVertical20,

            ////////////rate us /////////
            Row(
              children: [
                Image.asset(
                  AppAssets.rateUs,
                  height: 23,
                  width: 29,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  'Rate Us',
                  style: CommonTextStyle.drawerFont,
                )
              ],
            ).marginOnly(left: 15),
            CommonSpaces.spaceVertical20,

            ////////////more  apps/////////
            Row(
              children: [
                Image.asset(
                  AppAssets.moreApps,
                  height: 23,
                  width: 29,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  'More Apps',
                  style: CommonTextStyle.drawerFont,
                )
              ],
            ).marginOnly(left: 15),
            CommonSpaces.spaceVertical20,

            ////////////privacy policy/////////
            Row(
              children: [
                Image.asset(
                  AppAssets.privacyPolicy,
                  height: 23,
                  width: 29,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  'Privacy Policy',
                  style: CommonTextStyle.drawerFont,
                )
              ],
            ).marginOnly(left: 15),
            CommonSpaces.spaceVertical20,

            storage.hasData("userId")==true?
            GestureDetector(
              onTap: (){
                dashboardScreenController.logoutUser();
              },
              child: Row(
                children: [
                  const Icon(Icons.logout_rounded,color: Colors.black54),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Logout',
                    style: CommonTextStyle.drawerFont,
                  )
                ],
              ).marginOnly(left: 15),
            ):
            GestureDetector(
              onTap: (){
                Get.offAll(()=>const SplashScreen());
              },
              child: Row(
                children: [
                  const Icon(Icons.login,color: Colors.black54,),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Login',
                    style: CommonTextStyle.drawerFont,
                  )
                ],
              ).marginOnly(left: 15),
            )


          ],
        ),
      ),
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
                Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Image.asset(
                        AppAssets.threeLines,
                        width: 18,
                        height: 14,
                      ).marginOnly(left: 15),
                    );
                  },
                ),

                Text(
                  'Smarty Social',
                  style: TextStyle(
                      fontFamily: 'BirdsOfParadise',
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w400),
                ),
                // SizedBox(
                //   height: 25,
                //   width: 25,
                //   child: Image.asset(AppAssets.crown),
                // ),
              ],
            ).marginSymmetric(horizontal: 20, vertical: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    controller.genderSelect.value = "women";

                    Future.delayed(const Duration(seconds: 5), () {
                      // code to be executed after 2 seconds
                      if(controller.genderSelect.value !=""){
                        controller.genderSelect.value="";
                      }
                    });                    // openGalleryDialog(controller);
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
                    // openGalleryDialog(controller);
                    Future.delayed(const Duration(seconds: 5), () {
                      // code to be executed after 2 seconds
                      if(controller.genderSelect.value !=""){
                        controller.genderSelect.value="";
                      }
                    });

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
                                      onTap: () {
                                        controller.openCamera();
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

