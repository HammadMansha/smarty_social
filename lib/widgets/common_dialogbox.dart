import 'package:smarty_social/utils/libraries/app_libraries.dart';

class DialogHelper {
  static Future<void> showCommonDialog(
    BuildContext context, {
    required VoidCallback,
       required String ?textMessage,
        required String ?buttonMessage,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
              height: Get.height / 4,
              width: Get.width / 1,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CommonSpaces.spaceVertical10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          AppAssets.alertButton,
                        ),
                      ),
                      // const Icon(
                      //   Icons.cancel_outlined,
                      //   size: 29,
                      //   color: Colors.black,
                      // )
                    ],
                  ),
                  Center(
                    child: Text(
                      'Alert',
                      style: CommonTextStyle.profileName,
                    ),
                  ),
                  Center(
                    child: Text(
                      textMessage!,
                      style: CommonTextStyle.font14weightNormal342f,
                    ),
                  ),
                  CommonSpaces.spaceVertical10,
                  CommonButton(
                          height: 45,
                          width: Get.width,
                          text: buttonMessage!,
                          textStyle: CommonTextStyle.signupColor,
                          onPressed: VoidCallback,
                          fillColor: Colors.red)
                      .marginOnly(left: 15, right: 15)
                ],
              )),
        );
      },
    );
  }
}
