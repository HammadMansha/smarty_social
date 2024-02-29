import 'package:smarty_social/controller/explore/explore_controller.dart';
import 'package:smarty_social/utils/libraries/app_libraries.dart';
import '../../models/posts_model/posts_model.dart';
import '../../widgets/common_dialogbox.dart';

class ExploreScreen extends StatelessWidget with InitializeLocalStorage {
  ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardScreenController dashboardScreenController =
        Get.find<DashboardScreenController>();
    return CommonScaffold(
      drawer: Drawer(
        width: Get.width / 1.4,
        backgroundColor: AppColors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: Get.height / 4,
              width: Get.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppAssets.drawerImg,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
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

            storage.hasData("userId") == true
                ? GestureDetector(
                    onTap: () {
                      dashboardScreenController.logoutUser();
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.logout_rounded, color: Colors.black54),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Logout',
                          style: CommonTextStyle.drawerFont,
                        )
                      ],
                    ).marginOnly(left: 15),
                  )
                : GestureDetector(
                    onTap: () {
                      Get.offAll(() => const SplashScreen());
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.login,
                          color: Colors.black54,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Login',
                          style: CommonTextStyle.drawerFont,
                        )
                      ],
                    ).marginOnly(left: 15),
                  )
          ],
        ),
      ),
      body: SafeArea(
        child: bodyData(context),
      ),
    );
  }

  bodyData(BuildContext context) {
    ExploreController exploreController = Get.put(ExploreController());
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: RefreshIndicator(
        onRefresh: () async {
          exploreController.pullRefresh();
        },
        child: Obx(() {
          return exploreController.isLoading.value == true
              ? const AppLoader()
              : Column(
                  children: [
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
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    //
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: Text(
                    //     'Top Users',
                    //     style: CommonTextStyle.EditProfileFont,
                    //   ),
                    // ).marginOnly(left: 15),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // SizedBox(
                    //   height: 100, // Specify a height for the ListView
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: 10,
                    //     physics: const AlwaysScrollableScrollPhysics(),
                    //     itemBuilder: (context, index) {
                    //       return Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal:
                    //                 20), // Add equal horizontal space around each item
                    //         child: Column(
                    //           children: [
                    //             ClipOval(
                    //               child: CircleAvatar(
                    //                 backgroundColor: const Color(0xffE7E7E7),
                    //                 radius: 35,
                    //                 child: index == 0
                    //                     ? const Icon(
                    //                         Icons.add,
                    //                         size: 35,
                    //                       )
                    //                     : Image.asset(AppAssets.profiledemo2),
                    //               ),
                    //             ),
                    //             const SizedBox(height: 5),
                    //             Text(
                    //               index == 0 ? 'Share Story' : 'Names',
                    //               style: CommonTextStyle.font12weightNormal342f,
                    //             )
                    //           ],
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    const SizedBox(
                      height: 15,
                    ),

                    Expanded(
                      child: FutureBuilder<List<FeedPostData>?>(
                        future: exploreController.feedsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: AppLoader(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error if ui: ${snapshot.error}'),
                            );
                          } else {
                            final List<FeedPostData>? feeds = snapshot.data;
                            if (feeds != null && feeds.isNotEmpty) {
                              return ListView.separated(
                                itemCount: feeds.length,
                                reverse: false,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(
                                  height: 10,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  final feed = feeds[index];
                                  bool isFollowing = exploreController.following
                                      .any((user) =>
                                          user['user_id'] == feed.userId);

                                  return Container(
                                    height: Get.height / 2,
                                    width: Get.width,
                                    color: AppColors.colorF7F7,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            //user dp
                                            const CircleAvatar(
                                              backgroundImage:
                                                  AssetImage(AppAssets.noImage),
                                              radius: 30,
                                            ),

                                            //user name and time
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  feed.username!,
                                                  style: CommonTextStyle
                                                      .font14weightNormal342f,
                                                ).marginOnly(left: 8),
                                                Text(
                                                  exploreController
                                                      .formattedDate(
                                                    feed.timestamp,
                                                  ),
                                                  style: CommonTextStyle
                                                      .font12weightNormal342f,
                                                ).marginOnly(left: 8),
                                              ],
                                            ),
                                            const Spacer(),

                                            //Follow button
                                            if (!isFollowing &&
                                                feed.userId !=
                                                    exploreController
                                                        .myUserId) // Show follow button only if not following
                                              GestureDetector(
                                                onTap: () async {
                                                  if (storage
                                                          .hasData("userId") ==
                                                      true) {
                                                    await exploreController
                                                        .followUser(
                                                            feed.userId!)
                                                        .then((value) =>
                                                            exploreController
                                                                .pullRefresh());
                                                    exploreController.update();
                                                  } else {
                                                    CommonToast.showToast(
                                                        "Login first");
                                                  }
                                                },
                                                child: Container(
                                                  height: 29,
                                                  width: Get.width / 5,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xff808BFF),
                                                    // Add your decoration properties here
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  child: Center(
                                                    child: const Text(
                                                      'Follow',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          letterSpacing: 0.4,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: 'Nexa'),
                                                    ).marginOnly(top: 3),
                                                  ),
                                                ),
                                              )
                                            else if (feed.userId !=
                                                exploreController.myUserId)
                                              GestureDetector(
                                                onTap: () async {
                                                  if (storage.hasData(
                                                          "isAppOpen") ==
                                                      true) {
                                                    await exploreController
                                                        .unFollowUser(
                                                            feed.userId!)
                                                        .then((value) {
                                                      exploreController
                                                          .pullRefresh();
                                                      exploreController
                                                          .update();
                                                    });
                                                  } else {
                                                    CommonToast.showToast(
                                                        "Login first");
                                                  }
                                                },
                                                child: Container(
                                                  height: 29,
                                                  width: Get.width / 4,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xff808BFF),
                                                    // Add your decoration properties here
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  child: Center(
                                                    child: const Text(
                                                      'Following',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          letterSpacing: 0.4,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: 'Nexa'),
                                                    ).marginOnly(top: 3),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ).marginSymmetric(
                                            horizontal: 20, vertical: 20),

                                        //post image
                                        Expanded(
                                          child: InkWell(
                                            onDoubleTap: () {
                                              // AnimatedIcon(
                                              //   icon: AnimatedIcons.add_event,
                                              //   progress:AnimationController(
                                              //     vsync: this,
                                              //     duration: const Duration(milliseconds: 500), // Duration for the animation
                                              //   ),
                                              // );
                                              storage.hasData("userId") == true
                                                  ? exploreController
                                                      .likeValue(index)
                                                  : DialogHelper.showCommonDialog(
                                                      context,
                                                      VoidCallback: () {
                                                      Get.offAll(() =>
                                                          const SplashScreen());
                                                    },
                                                      textMessage:
                                                          'Please Sign Up to access the functionality ',
                                                      buttonMessage: 'Signup');
                                              if (kDebugMode) {
                                                print('double tap done');
                                              }
                                            },
                                            child: SizedBox(
                                              width: Get.width,
                                              child: CachedNetworkImage(
                                                imageUrl: feed.picUrl,
                                                placeholder: (c, e) =>
                                                    Image.asset(
                                                        AppAssets
                                                            .placeHolderNoImage,
                                                        fit: BoxFit.scaleDown),
                                                errorWidget: (c, e, r) =>
                                                    Image.asset(
                                                        AppAssets
                                                            .placeHolderNoImage,
                                                        fit: BoxFit.scaleDown),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //Like button
                                        SizedBox(
                                          height: 50,
                                          width: Get.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      child: Obx(() {
                                                        return GestureDetector(
                                                          onTap: () => storage
                                                                      .hasData(
                                                                          "isAppOpen") ==
                                                                  true
                                                              ? exploreController
                                                                  .likeValue(
                                                                      index)
                                                              : DialogHelper.showCommonDialog(
                                                                  context,
                                                                  VoidCallback:
                                                                      () {
                                                                  Get.offAll(() =>
                                                                      const SplashScreen());
                                                                },
                                                                  textMessage:
                                                                      'Please Sign Up to access the functionality ',
                                                                  buttonMessage:
                                                                      'Signup'),
                                                          child: Icon(
                                                            exploreController
                                                                            .likedList[
                                                                        index] ==
                                                                    true
                                                                ? Icons.favorite
                                                                : Icons
                                                                    .favorite_border,
                                                            size: 24,
                                                            color: exploreController
                                                                        .likedList[
                                                                    index]
                                                                ? Colors.red
                                                                : Colors.black,
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "236",
                                                      style: CommonTextStyle
                                                          .font12weightNormal342f,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      AppAssets.comment,
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "133",
                                                      style: CommonTextStyle
                                                          .font12weightNormal342f,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      AppAssets.view,
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "1145",
                                                      style: CommonTextStyle
                                                          .font12weightNormal342f,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      AppAssets.share,
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    const Text("23"),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ).marginSymmetric(horizontal: 20),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Center(
                                child: Text(
                                  'No data available',
                                  style: CommonTextStyle
                                      .font16weight400BlackNexRegular,
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),

                    // Expanded(
                    //   child: ListView.separated(
                    //     itemCount: 3,
                    //     separatorBuilder: (BuildContext context, int index) =>
                    //         const SizedBox(
                    //       height: 10,
                    //     ),
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return Container(
                    //         height: Get.height / 2,
                    //         width: Get.width,
                    //         color: AppColors.colorF7F7,
                    //         child: Column(
                    //           children: [
                    //             Row(
                    //               children: [
                    //                 //user dp
                    //                 const CircleAvatar(
                    //                   backgroundImage: AssetImage(AppAssets.userDp),
                    //                   radius: 30,
                    //                 ),
                    //
                    //                 //user name and time
                    //                 Column(
                    //                   children: [
                    //                     Text(
                    //                       "Ana_Solam",
                    //                       style: CommonTextStyle.font14weightNormal342f,
                    //                     ).marginOnly(left: 15),
                    //                     Text(
                    //                       "Yesterday",
                    //                       style: CommonTextStyle.font12weightNormal342f,
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 const Spacer(),
                    //
                    //                 //Follow button
                    //                 SizedBox(
                    //                   height: 30,
                    //                   child: Image.asset(AppAssets.followBtn),
                    //                 ),
                    //               ],
                    //             ).marginSymmetric(horizontal: 20, vertical: 20),
                    //
                    //             //post image
                    //             Expanded(
                    //               child: SizedBox(
                    //                 width: Get.width,
                    //                 child: Image.asset(
                    //                   AppAssets.exploreImg,
                    //                   fit: BoxFit.fill,
                    //                 ),
                    //               ),
                    //             ),
                    //
                    //             //Like button
                    //             SizedBox(
                    //               height: 50,
                    //               width: Get.width,
                    //               child: Row(
                    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   SizedBox(
                    //                     child: Row(
                    //                       children: [
                    //                         const SizedBox(
                    //                             child: Icon(Icons.favorite,size: 24,color: AppColors.blackColor,)
                    //
                    //                         ),
                    //                         const SizedBox(
                    //                           width: 5,
                    //                         ),
                    //                         Text(
                    //                           "236",
                    //                           style: CommonTextStyle
                    //                               .font12weightNormal342f,
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   SizedBox(
                    //                     child: Row(
                    //                       children: [
                    //                         Image.asset(
                    //                           AppAssets.comment,
                    //                           height: 20,
                    //                           width: 20,
                    //                         ),
                    //                         const SizedBox(
                    //                           width: 5,
                    //                         ),
                    //                         Text(
                    //                           "133",
                    //                           style: CommonTextStyle
                    //                               .font12weightNormal342f,
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   SizedBox(
                    //                     child: Row(
                    //                       children: [
                    //                         Image.asset(
                    //                           AppAssets.view,
                    //                           height: 20,
                    //                           width: 20,
                    //                         ),
                    //                         const SizedBox(
                    //                           width: 5,
                    //                         ),
                    //                         Text(
                    //                           "1145",
                    //                           style: CommonTextStyle
                    //                               .font12weightNormal342f,
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   SizedBox(
                    //                     child: Row(
                    //                       children: [
                    //                         Image.asset(
                    //                           AppAssets.share,
                    //                           height: 20,
                    //                           width: 20,
                    //                         ),
                    //                         const SizedBox(
                    //                           width: 5,
                    //                         ),
                    //                         const Text("23"),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ).marginSymmetric(horizontal: 20),
                    //             ),
                    //           ],
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    //const SizedBox(height: 30,),
                  ],
                );
        }),
      ),
    );
  }
}
