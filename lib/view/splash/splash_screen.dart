import '../../utils/libraries/app_libraries.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        extendBody:true,
        body:bodyData(context),
    );
  }

  bodyData(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // SvgPicture.asset(
          //   'assets/images/svgtest.svg',
          //   semanticsLabel: 'My SVG Image',
          //   // height: 100,
          //   // width: 70,
          // ),


          Align(
            alignment: Alignment.center,
            child: Image.asset(AppAssets.splashScreen),
          ),
          CommonSpaces.spaceVertical110,

          InkWell(
            onTap: () {},
            child: SizedBox(
              height: 30,
              width: Get.width / 2,
              child: Image.asset(AppAssets.newJourney),
            ),
          ),
          CommonSpaces.spaceVertical50,

          InkWell(
            onTap: () {
              Get.toNamed(Routes.signUpScreen);

            },
            child: SizedBox(
              height: 50,
              width: Get.width / 2.25,
              child: Image.asset(AppAssets.signupSplash),
            ),
          ),

          CommonSpaces.spaceVertical10,

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       AppStrings.alreadyHaveAccount,
          //       style: CommonTextStyle.font16weight400BlackNexRegular,
          //     ),
          //     Text(
          //       AppStrings.login,
          //       style: CommonTextStyle.font16weight400Da33NexRegular,
          //     ),
          //   ],
          // ),

          //Sign up
          InkWell(
            onTap: () {
              Get.toNamed(Routes.loginScreen);
            },
            child: SizedBox(
              height: 30,
              width: Get.width / 2,
              child: Image.asset(AppAssets.alreadyAcc),
            ),
          ),

CommonSpaces.spaceVertical10,
//Skip
          InkWell(
            onTap: () {
              Get.off(()=>const CreatePostScreen());
            },
            child: SizedBox(
              height: 18,
              width: Get.width / 2,
              child: Image.asset(AppAssets.skip),
            ),
          ),


          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }


}
