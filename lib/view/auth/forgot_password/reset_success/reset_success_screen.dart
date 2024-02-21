import '../../../../utils/libraries/app_libraries.dart';

class ResetPasswordSuccess extends StatelessWidget {
  const ResetPasswordSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: bodyData(context),
    );
  }

  bodyData(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: Get.width / 1.5,
                child: Image.asset(AppAssets.successReset),
              ),
            ),
            CommonSpaces.spaceVertical20,
            GestureDetector(
              onTap: () {
                Get.offAll(() => LoginScreen());
              },
              child: Container(
                height: 50,
                width: Get.width / 1.4,

                padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 12), // Adjust padding to fit your design
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF808BFF),
                      Color(0xffC135F6), // Start color of the gradient
                      Color(0xFFF431A7), // End color of the gradient
                    ],
                  ),
                  borderRadius: BorderRadius.circular(
                      30), // Adjust border radius to fit your design
                ),
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontFamily: 'Nexa',
                      color: Colors.white,
                      fontSize: 18, // Adjust font size to fit your design
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
