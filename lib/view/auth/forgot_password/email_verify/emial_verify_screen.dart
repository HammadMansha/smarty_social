import '../../../../utils/libraries/app_libraries.dart';

class EmailVerify extends StatelessWidget
    with  ValidateUserEmail {
  EmailVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      isAppbarShow: true,
      body: bodyData(context),
    );
  }

  bodyData(BuildContext context) {
        return GetBuilder<EmailVerificationController>(init:EmailVerificationController() ,
          builder: (controller) {
            return SizedBox(
              height: Get.height,
              width: Get.width,
              child:controller.isLoading.value==true?const AppLoader(): SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 100,
                        child: Image.asset(AppAssets.emailVerify),
                      ),
                      CommonSpaces.spaceVertical70,
                      SizedBox(
                        height: 60,
                        child: Image.asset(AppAssets.getCode),
                      ),
                      CommonSpaces.spaceVertical30,

                      SizedBox(
                        width: Get.width / 2,
                        child: Wrap(spacing: 0.0, runSpacing: 0.0, children: [
                          PinCodeTextField(
                            pastedTextStyle:
                                CommonTextStyle.font16weight400BlackNexRegular,
                            length: 4,
                            animationType: AnimationType.fade,
                            textStyle: CommonTextStyle.font16weight400BlackNexRegular,
                            // ignore: body_might_complete_normally_nullable
                            validator: (v) {
                              if (controller.pin.text.isEmpty) {
                                return 'Enter pin';
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                              selectedFillColor: AppColors.pinFieldBackground,
                              selectedColor: AppColors.pinFieldBackground,
                              borderWidth: 2,
                              disabledColor: AppColors.pinFieldBackground,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(4),
                              fieldHeight: 44,
                              fieldWidth: 40,
                              inactiveColor: AppColors.pinFieldBackground,
                              inactiveFillColor: AppColors.pinFieldBackground,
                              activeColor: AppColors.pinFieldBackground,
                              activeFillColor: AppColors.pinFieldBackground,
                            ),
                            cursorColor: Colors.white,
                            animationDuration: const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            controller: controller.pin,
                            keyboardType: TextInputType.number,
                            boxShadows: const [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.black12,
                                blurRadius: 10,
                              )
                            ],
                            onCompleted: (v)async {
                              //await controller.verifyOtp();
                            },
                            onChanged: (value) {
                              controller.isEmpty.value = false;
                              controller.update();
                            },
                            beforeTextPaste: (text) {
                              return true;
                            },
                            appContext: context,
                          ),
                        ]),
                      ),
                      //Resend button
                      InkWell(
                        onTap: () {},
                        child: SizedBox(
                          height: 30,
                          width: Get.width / 2,
                          child: Image.asset(AppAssets.resendText),
                        ),
                      ),

                      CommonSpaces.spaceVertical80,
                      //Verify and proceed
                      InkWell(
                        onTap: () async{
                          if (controller.formKey.currentState!.validate()) {
                            print("abcd");
                           await controller.verifyOtp();
                          }
                        },
                        child: SizedBox(
                          height: 50,
                          width: Get.width,
                          child: Image.asset(AppAssets.verifyBtn),
                        ),
                      ),
                    ],
                  ).marginSymmetric(horizontal: 40),
                ),
              ),
            );
          }
        );

  }

}
