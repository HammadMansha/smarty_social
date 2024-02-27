import 'package:smarty_social/controller/splash_screen/splash_screen_controller.dart';
import '../../utils/libraries/app_libraries.dart';
import '../../widgets/common_dialogbox.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Splash build method called');

    return GetBuilder<SplashScreenController>(
      init: SplashScreenController(),
      builder: (_) {
        return Scaffold(
          body: bodyData(context, _),
        );
      },
    );
  }

  Widget bodyData(BuildContext context, SplashScreenController _) {
    debugPrint('Splash build method called 2');

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          height: 40,
        ),
        Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              saveImageDialog();
            },
            child: Image.asset(
              AppAssets.splashScreen,
              height: Get.height / 4,
              width: Get.width / 2.5,
            ),
          ),
        ),

        CommonSpaces.spaceVertical50,
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
        // ElevatedButton(
        //   onPressed: () {
        //     Get.toNamed(Routes.signUpScreen);
        //   },
        //   style: ButtonStyle(
        //     minimumSize: MaterialStateProperty.all<Size>(
        //       Size(Get.width / 2, 50), // Set the size of the button
        //     ),
        //     backgroundColor: MaterialStateProperty.resolveWith<Color>(
        //       (Set<MaterialState> states) {
        //         // Set the background color of the button
        //         if (states.contains(MaterialState.pressed)) {
        //           return Colors.blue
        //               .withOpacity(0.5); // Change the color when pressed
        //         }
        //         return Colors.blue; // Default color
        //       },
        //     ),
        //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //       RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(30.0), // Set border radius
        //       ),
        //     ),
        //   ),
        //   child: Text(
        //     'Signup',
        //     style: CommonTextStyle.signupColor,
        //   ),
        // ),

        Container(
          height: 50, // specify the height
          width: Get.width / 2,

          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Color(0xffC135F6),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF808BFF),
                Color(0xffC135F6), // Start color of the gradient
                Color(0xFFF431A7), // End color of the gradient
              ],
            ),
          ),

          child: MaterialButton(
            onPressed: () {
              Get.toNamed(Routes.signUpScreen);
            },

            textColor: Colors.white,
            child: Text(
              'Signup',
              style: CommonTextStyle.signupColor,
            ),

            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(30), // apply rounded corners
            //   // apply border
            // ), // specify the width
          ),
        ),

        CommonSpaces.spaceVertical10,

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Already have an account? ',
              style: TextStyle(
                fontFamily: 'Nexa',
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.loginScreen);
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xffDA33CF),
                  fontFamily: 'Nexa',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Color(0xffDA33CF),
                ),
              ),
            )
          ],
        ),

        CommonSpaces.spaceVertical10,
//Skip
        InkWell(
          onTap: () {
            Get.off(() => DashboardScreen());
          },
          child: const Text(
            'Skip',
            style: TextStyle(
              fontFamily: 'Nexa',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff969696),
            ),
          ),
        ),

        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

void saveImageDialog() {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.save_alt_sharp,
                      color: Colors.black,
                      size: 50,
                    ),
                    Icon(
                      Icons.upload,
                      color: Colors.black,
                      size: 50,
                    ),
                  ],
                ).marginOnly(left: 30, right: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Save',
                      style: CommonTextStyle.font14weightNormal342f,
                    ).marginOnly(left: 5),
                    Text(
                      'Post',
                      style: CommonTextStyle.font14weightNormal342f,
                    )
                  ],
                ).marginOnly(left: 30, right: 30),
              ],
            ))),
  );
}
