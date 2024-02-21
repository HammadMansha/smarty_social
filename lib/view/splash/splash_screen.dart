import '../../utils/libraries/app_libraries.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: bodyData(context),
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
          CommonSpaces.spaceVertical10,
          const Text(
            'Smarty Social',
            style: TextStyle(
                fontFamily: 'BirdsOfParadise',
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.w400),
          ),
          CommonSpaces.spaceVertical100,

          const Text(
            AppStrings.newJourney,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.color342F2F,
              fontFamily: 'Nexa',
            ),
          ),

          CommonSpaces.spaceVertical50,

          CommonButton(
            width: Get.width / 2,
            fillColor: Colors.red,
            text: 'Signup',
            textStyle: CommonTextStyle.signupColor,
            onPressed: () {
              Get.toNamed(Routes.signUpScreen);
            },
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
                Get.off(() => const CreatePostScreen());
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  fontFamily: 'Nexa',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff969696),
                ),
              )),

          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
