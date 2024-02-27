import 'package:smarty_social/utils/libraries/app_libraries.dart';
import '../../controller/profile/profile_controller.dart';
import '../../services/auth_service/auth_services.dart';

class ProfileScreen extends StatelessWidget with InitializeLocalStorage {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = Get.find<AuthService>();

    return GetBuilder<ProfileScreenController>(
      init: ProfileScreenController(),
      builder: (_) {
        return SafeArea(
            child: authService.loggedInUser == true
                ? Scaffold(
                    drawer: Drawer(
                      width: Get.width / 1.4,
                      backgroundColor: AppColors.white,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                          CommonSpaces.spaceVertical50,
                          Row(
                            children: [
                              Image.asset(
                                AppAssets.kingIcon2,
                                height: 23,
                                width: 29,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Get Premium',
                                style: CommonTextStyle.drawerFont,
                              )
                            ],
                          ).marginOnly(left: 15),
                          CommonSpaces.spaceVertical20,
                          Row(
                            children: [
                              Image.asset(
                                AppAssets.howtouse,
                                height: 23,
                                width: 29,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                'How to Use',
                                style: CommonTextStyle.drawerFont,
                              )
                            ],
                          ).marginOnly(left: 15),
                          CommonSpaces.spaceVertical20,

                          //////////Account privacy//////////
                          Row(
                            children: [
                              Image.asset(
                                AppAssets.privacyIcon,
                                height: 23,
                                width: 29,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Account Privacy',
                                style: CommonTextStyle.drawerFont,
                              )
                            ],
                          ).marginOnly(left: 15),
                          CommonSpaces.spaceVertical20,
                          ////////////Share /////////
                          Row(
                            children: [
                              Image.asset(
                                AppAssets.shareIcon,
                                height: 23,
                                width: 29,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Share',
                                style: CommonTextStyle.drawerFont,
                              )
                            ],
                          ).marginOnly(left: 15),
                          CommonSpaces.spaceVertical20,

                          ////////////Languages /////////
                          Row(
                            children: [
                              Image.asset(
                                AppAssets.languagesIcon,
                                height: 23,
                                width: 29,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Languages',
                                style: CommonTextStyle.drawerFont,
                              )
                            ],
                          ).marginOnly(left: 15),
                          CommonSpaces.spaceVertical20,

                          ////////////rate us /////////
                          Row(
                            children: [
                              Image.asset(
                                AppAssets.rateUs,
                                height: 23,
                                width: 29,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Rate Us',
                                style: CommonTextStyle.drawerFont,
                              )
                            ],
                          ).marginOnly(left: 15),
                          CommonSpaces.spaceVertical20,

                          ////////////more  apps/////////
                          Row(
                            children: [
                              Image.asset(
                                AppAssets.moreApps,
                                height: 23,
                                width: 29,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                'More Apps',
                                style: CommonTextStyle.drawerFont,
                              )
                            ],
                          ).marginOnly(left: 15),
                          CommonSpaces.spaceVertical20,

                          ////////////privacy policy/////////
                          Row(
                            children: [
                              Image.asset(
                                AppAssets.privacyPolicy,
                                height: 23,
                                width: 29,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Privacy Policy',
                                style: CommonTextStyle.drawerFont,
                              )
                            ],
                          ).marginOnly(left: 15),
                          CommonSpaces.spaceVertical20,
                        ],
                      ),
                    ),
                    body: bodyData(context, _),
                  )
                : Scaffold(
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Please login first',
                            style: CommonTextStyle.EditProfileFont,
                          ),
                        ),
                        CommonSpaces.spaceVertical30,
                        CommonButton(
                          width: Get.width / 1.5,
                          text: 'Login',
                          textStyle: CommonTextStyle.signupColor,
                          onPressed: () async {
                            Get.toNamed(Routes.loginScreen);
                          },
                          fillColor: Colors.red,
                        ),
                      ],
                    ),
                  ));
      },
    );
  }

  bodyData(BuildContext context, ProfileScreenController _) {
    return SafeArea(
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Obx(() {
          return _.isLoading.value == true
              ? const AppLoader()
              : Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Builder(
                          builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: Image.asset(
                                AppAssets.threeLines,
                                width: 18,
                                height: 14,
                              ).marginOnly(left: 15),
                            );
                          },
                        ),
                        const Text(
                          'Smarty Social',
                          style: TextStyle(
                              fontFamily: 'BirdsOfParadise',
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: FontWeight.w400),
                        ).marginOnly(left: 12, top: 5),
                        const Spacer(),
                        // const Icon(
                        //   Icons.notifications,
                        //   color: Color(0xff80ABFF),
                        // ),
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        // Image.asset(
                        //   AppAssets.iconKing,
                        //   width: 25,
                        //   height: 22,
                        // ).marginOnly(right: 12),
                      ],
                    ),

                    CommonSpaces.spaceVertical10,

                    Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          child: ClipOval(
                            child: Image.asset(
                              AppAssets.noImage,
                              fit: BoxFit.cover,
                              width:
                                  130, // Double the radius to fit within the CircleAvatar
                              height:
                                  130, // Double the radius to fit within the CircleAvatar
                            ),
                          ),
                        ).marginOnly(left: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_.username, style: CommonTextStyle.profileName)
                                .marginOnly(left: 12),
                            // Text('Stressed Blessed Coffee Obsessed',
                            //         style: CommonTextStyle.profileDetails)
                            //     .marginOnly(left: 12),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  AppAssets.addstory,
                                  height: 25,
                                  width: 100,
                                ).marginOnly(left: 12),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.editProfileScreen);
                                  },
                                  child: Image.asset(
                                    AppAssets.editProfile1,
                                    height: 25,
                                    width: 100,
                                  ).marginOnly(left: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),

                    CommonSpaces.spaceVertical20,

                    Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _.myPosts.length.toString(),
                            style: CommonTextStyle.profileName,
                          ).marginOnly(left: 10),
                          Text(
                            _.followers.toString(),
                            style: CommonTextStyle.profileName,
                          ),
                          Text(
                            _.following.toString(),
                            style: CommonTextStyle.profileName,
                          ).marginOnly(right: 20),
                        ],
                      ).marginOnly(left: 15, right: 15);
                    }),
                    CommonSpaces.spaceVertical10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Posts',
                          style: CommonTextStyle.profileDetails,
                        ),
                        Text(
                          'Followers',
                          style: CommonTextStyle.profileDetails,
                        ),
                        Text(
                          'Following',
                          style: CommonTextStyle.profileDetails,
                        ),
                      ],
                    ).marginOnly(left: 15, right: 15),
                    CommonSpaces.spaceVertical10,

                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              3, // Maximum of three items in the same line
                          mainAxisSpacing:
                              10, // Adjust spacing between rows vertically
                          crossAxisSpacing:
                              10, // Adjust spacing between items horizontally
                        ),
                        itemCount: _.myPosts.length, // Total number of items
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 136,
                            width: 136,
                            child: Image.network(_.myPosts[index]["picURL"]),
                          );
                        },
                      ),
                    )

                    //const SizedBox(height: 30,),
                  ],
                );
        }),
      ),
    );
  }
}
