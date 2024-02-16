import 'package:smarty_social/utils/libraries/app_libraries.dart';

class ResetPassword extends StatelessWidget with CommonVariables,ValidateUserEmail {
   ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      isAppbarShow: true,
      body: bodyData(context),
    );
  }

  bodyData(BuildContext context) {
    ResetPasswordController controller =
    Get.put(ResetPasswordController());
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                width: Get.width/1.6,
                child: Image.asset(AppAssets.resetPassword),
              ),
              CommonSpaces.spaceVertical40,
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  AppStrings.password,
                  style: CommonTextStyle.font16weight400BlackNexRegular,
                ),
              ),
              Obx(
                    () => CommonTextField(
                  controller: controller.password,
                  bordercolor: AppColors.colorC1c1,
                  disableBorderColor: AppColors.colorC1c1,
                  textColor: AppColors.blackColor,
                  isTextHidden: secureText.value,
                  togglePassword: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
                  ],
                  toggleIcon: secureText.value == true
                      ? Icons.visibility_off_outlined
                      : Icons.remove_red_eye_outlined,
                  toggleFunction: () {
                    secureText.value = !secureText.value;
                    controller.update();
                  },
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'This filed is required';
                    } else if (isPasswordEmpty(value.toString()) != null) {
                      return isPasswordEmpty(value.toString());
                    }
                    return null;
                  },
                ),
              ),
              CommonSpaces.spaceVertical10,
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  AppStrings.confirmPassword,
                  style: CommonTextStyle.font16weight400BlackNexRegular,
                ),
              ),
              Obx(
                    () => CommonTextField(
                  controller: controller.confirmPassword,
                  bordercolor: AppColors.colorC1c1,
                  disableBorderColor: AppColors.colorC1c1,
                  textColor: AppColors.blackColor,
                  isTextHidden: secureText2.value,
                  togglePassword: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
                  ],
                  toggleIcon: secureText2.value == true
                      ? Icons.visibility_off_outlined
                      : Icons.remove_red_eye_outlined,
                  toggleFunction: () {
                    secureText2.value = !secureText2.value;
                    controller.update();
                  },
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'This filed is required';
                    } else if (isPasswordEmpty(value.toString()) != null) {
                      return isPasswordEmpty(value.toString());
                    }
                    return null;
                  },
                ),
              ),



              CommonSpaces.spaceVertical100,
              //Verify and proceed
              InkWell(
                onTap: () async{
                  if (formKey.currentState!.validate()) {
                    if(controller.password.text==controller.confirmPassword.text) {
                      controller.resetPassword();
                    }
                    else{
                      CommonToast.showToast( AppStrings.passwordNotMatch);
                    }
                  }
                },
                child: SizedBox(
                  height: 50,
                  width: Get.width,
                  child: Image.asset(AppAssets.continueBtn),
                ),
              ),
            ],
          ).marginSymmetric(horizontal: 40),
        ),
      ),
    );
  }

}
