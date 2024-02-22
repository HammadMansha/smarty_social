import 'package:smarty_social/controller/auth/forogt_passowrd/forgot_password_controller.dart';
import 'package:smarty_social/utils/libraries/app_libraries.dart';

class ForgotPassword extends StatelessWidget
    with CommonVariables, ValidateUserEmail {
  ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      isAppbarShow: true,
      body: bodyData(),
    );
  }

  bodyData() {
    ForgotPasswordController controller = Get.put(ForgotPasswordController());
    return Obx(() {
      return SizedBox(
        height: Get.height,
        width: Get.width,
        child: controller.isLoading.value == true
            ? const Center(child: AppLoader())
            : SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 100,
                        child: Image.asset(AppAssets.forgotPassword),
                      ),
                      CommonSpaces.spaceVertical70,
                      SizedBox(
                        height: 60,
                        child: Image.asset(AppAssets.emailHere),
                      ),
                      CommonSpaces.spaceVertical30,
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          AppStrings.email,
                          style: CommonTextStyle.font16weight400BlackNexRegular,
                        ),
                      ),
                      CommonTextField(
                        controller: controller.email,
                        bordercolor: AppColors.colorC1c1,
                        disableBorderColor: AppColors.colorC1c1,
                        textColor: AppColors.blackColor,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'This filed is required';
                          } else {
                            return null;
                          }
                        },
                      ),
                      CommonSpaces.spaceVertical50,
                      CommonButton(
                        width: Get.width / 1,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await controller.forgotPassword();
                          }
                        },
                        textStyle: CommonTextStyle.signupColor,
                        fillColor: Colors.red,
                        text: 'Recover Password',
                      ),
                    ],
                  ).marginSymmetric(horizontal: 40),
                ),
              ),
      );
    });
  }
}
