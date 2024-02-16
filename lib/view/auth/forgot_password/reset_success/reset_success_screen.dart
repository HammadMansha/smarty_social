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
            InkWell(
              onTap: () {
                Get.offAll(() => LoginScreen());
              },
              child: SizedBox(
                width: Get.width / 1.5,
                child: Image.asset(AppAssets.loginBtn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
