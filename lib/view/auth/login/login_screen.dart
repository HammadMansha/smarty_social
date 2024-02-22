import '../../../utils/libraries/app_libraries.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget
    with CommonVariables, ValidateUserEmail, InitializeLocalStorage {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      isAppbarShow: true,
      body: bodyData(),
    );
  }

  bodyData() {
    LoginController loginController = Get.put(LoginController());
    return Obx(
      () => Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white,
        child: loginController.isLoading.value == true
            ? const AppLoader()
            : Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Center(
                        child: Container(
                          height: 110,
                          width: 110,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppAssets.login),
                                fit: BoxFit.contain),
                          ),
                        ),
                      ),

                      CommonSpaces.spaceVertical50,
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          AppStrings.userNameEmail,
                          style: CommonTextStyle.font16weight400BlackNexRegular,
                        ),
                      ),
                      CommonTextField(
                        controller: loginController.email,
                        bordercolor: AppColors.colorC1c1,
                        disableBorderColor: AppColors.colorC1c1,
                        textColor: AppColors.blackColor,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'This filed is required';
                          }
                          return null;
                        },
                      ),
                      CommonSpaces.spaceVertical10,

                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          AppStrings.password,
                          style: CommonTextStyle.font16weight400BlackNexRegular,
                        ),
                      ),

                      Obx(
                        () => CommonTextField(
                          controller: loginController.password,
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
                            loginController.update();
                          },
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'This filed is required';
                            } else if (isPasswordEmpty(value.toString()) !=
                                null) {
                              return isPasswordEmpty(value.toString());
                            }
                            return null;
                          },
                        ),
                      ),

                      CommonSpaces.spaceVertical10,
                      //Remember me
                      Row(
                        children: [
                          Obx(
                            () => GestureDetector(
                              onTap: () async {
                                if (loginController.rememberMe.value == false) {
                                  loginController.rememberMe.value = true;
                                } else {
                                  loginController.rememberMe.value = false;
                                }
                              },
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  height: 14,
                                  width: 14,
                                  decoration: BoxDecoration(
                                    color:
                                        loginController.rememberMe.value == true
                                            ? AppColors.color8584FE
                                            : Colors.transparent,
                                    border: Border.all(
                                        color: AppColors.color8584FE),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child:
                                      loginController.rememberMe.value == true
                                          ? const Center(
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 12,
                                              ),
                                            )
                                          : const SizedBox(),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Remember me?",
                            style:
                                CommonTextStyle.font16weight4005252NexRegular,
                          ).marginOnly(left: 5)
                        ],
                      ),

                      //Login button
                      CommonSpaces.spaceVertical50,

                      CommonButton(
                        width: Get.width / 1,
                        text: 'Login',
                        textStyle: CommonTextStyle.signupColor,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await loginController.loginUser();
                          }
                        },
                        fillColor: Colors.red,
                      ),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.forgotPasswordScreen);
                          },
                          child: Text(
                            "Forgot Password?",
                            style:
                                CommonTextStyle.font14weight4009595NexRegular,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 50,
                        width: Get.width,
                        child: Image.asset(AppAssets.dividerOr),
                      ),

                      SizedBox(
                        height: 40,
                        width: Get.width,
                        child: Image.asset(AppAssets.socialLogin),
                      ),

                      // CommonButton(
                      //   text: "Login",
                      //   textStyle:
                      //       CommonTextStyle.font16weight400WhiteNexRegular,
                      //   onPressed: () {
                      //     if (formKey.currentState!.validate()) {}
                      //   },
                      //   fillColor: Colors.transparent,
                      //   height: 65,
                      //   width: Get.width,
                      // ),
                    ],
                  ).marginSymmetric(horizontal: 40),
                ),
              ),
      ),
    );
  }
}
