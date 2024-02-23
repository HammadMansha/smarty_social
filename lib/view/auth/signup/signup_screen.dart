import 'package:smarty_social/utils/libraries/app_libraries.dart';

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
                                child: InkWell(
                                  onTap: () {
                                    controller.signUpDialog();
                                  },
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image:
                                              AssetImage(AppAssets.profilePic),
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'SIGNUP',
                                style: TextStyle(
                                  fontFamily: 'Nexa',
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      26, // Adjust the font size as per your requirement
                                  foreground:
                                      Paint() // This applies the paint to the text
                                        ..shader = const LinearGradient(
                                          // This creates the same gradient as the container
                                          colors: [
                                            Color(0xFF808BFF),
                                            Color(
                                                0xffC135F6), // Start color of the gradient
                                            Color(
                                                0xFFF431A7), // End color of the gradient
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ).createShader(const Rect.fromLTWH(
                                            0,
                                            0,
                                            200,
                                            70)), // This creates the shader for the gradient
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
