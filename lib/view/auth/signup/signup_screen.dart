import 'package:smarty_social/utils/libraries/app_libraries.dart';
import 'package:smarty_social/widgets/common_toast/common_toast.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget
    with CommonVariables, ValidateUserEmail {
  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      isAppbarShow: true,
      body: bodyData(context),
    );
  }

  Widget bodyData(BuildContext context) {
    SignUpController controller = Get.put(SignUpController());
    return SafeArea(
      child: Obx(() {
        return CommonContainer(
          child: controller.isLoading.value == true
              ? const AppLoader()
              : SingleChildScrollView(
                  child: controller.isLoading.value == true
                      ? const AppLoader()
                      : Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30),
                              Center(
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(AppAssets.profilePic),
                                        fit: BoxFit.contain),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 70,
                                width: 100,
                                child: Image.asset(
                                  AppAssets.signUp,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              CommonSpaces.spaceVertical10,
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  AppStrings.userName,
                                  style: CommonTextStyle
                                      .font16weight400BlackNexRegular,
                                ),
                              ),
                              CommonTextField(
                                controller: controller.username,
                                bordercolor: AppColors.colorC1c1,
                                disableBorderColor: AppColors.colorC1c1,
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'This filed is required';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              CommonSpaces.spaceVertical10,
                              Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    AppStrings.email,
                                    style: CommonTextStyle
                                        .font16weight400BlackNexRegular,
                                  )),
                              CommonTextField(
                                controller: controller.email,
                                bordercolor: AppColors.colorC1c1,
                                disableBorderColor: AppColors.colorC1c1,
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'This filed is required';
                                  } else if (!isValidEmail(value.toString())) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              CommonSpaces.spaceVertical10,
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  AppStrings.password,
                                  style: CommonTextStyle
                                      .font16weight400BlackNexRegular,
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
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r"\s\b|\b\s"))
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
                                    } else if (isPasswordEmpty(
                                            value.toString()) !=
                                        null) {
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
                                  style: CommonTextStyle
                                      .font16weight400BlackNexRegular,
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
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r"\s\b|\b\s"))
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
                                    } else if (isPasswordEmpty(
                                            value.toString()) !=
                                        null) {
                                      return isPasswordEmpty(value.toString());
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              CommonSpaces.spaceVertical70,
                              CommonButton(
                                width: Get.width / 1,
                                text: 'Signup',
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    if (controller.password.text ==
                                        controller.confirmPassword.text) {
                                      controller.registerUser();
                                    } else {
                                      CommonToast.showToast(
                                          AppStrings.passwordNotMatch);
                                    }
                                  }
                                },
                                fillColor: Colors.red,
                                textStyle: CommonTextStyle.signupColor,
                              ),
                            ],
                          ).marginSymmetric(horizontal: 20),
                        ),
                ),
        );
      }),
    );
  }
}
