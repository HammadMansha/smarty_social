import 'package:smarty_social/controller/explore/explore_controller.dart';
import 'package:smarty_social/utils/libraries/app_libraries.dart';

import '../../models/posts_model/posts_model.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        body: SafeArea(
      child: bodyData(context),
    ));
  }

  bodyData(BuildContext context) {
    ExploreController exploreController = Get.put(ExploreController());
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: RefreshIndicator(
        onRefresh: () async {
          exploreController.feedsFuture = exploreController.getFeeds();
        },
        child: Obx(() {
          return exploreController.isLoading.value == true
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
                    const SizedBox(
                      height: 10,
                    ),

                    // SizedBox(
                    //   height: Get.height / 4,
                    //   width: Get.width,
                    //   child: Image.asset(AppAssets.feedUp),
                    // ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Top Users',
                        style: CommonTextStyle.EditProfileFont,
                      ),
                    ).marginOnly(left: 15),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 100, // Specify a height for the ListView
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal:
                                    20), // Add equal horizontal space around each item
                            child: Column(
                              children: [
                                ClipOval(
                                  child: CircleAvatar(
                                    backgroundColor: const Color(0xffE7E7E7),
                                    radius: 35,
                                    child: index == 0
                                        ? const Icon(
                                            Icons.add,
                                            size: 35,
                                          )
                                        : Image.asset(AppAssets.profiledemo2),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  index == 0 ? 'Share Story' : 'Names',
                                  style: CommonTextStyle.font12weightNormal342f,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
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
                                                  AssetImage(AppAssets.userDp),
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
                                            feed.userId !=
                                                    exploreController.myUserId
                                                ? GestureDetector(
                                                    onTap: () async {
                                                      await exploreController
                                                          .followUser(
                                                              feed.userId!);
                                                    },
                                                    child: SizedBox(
                                                      height: 30,
                                                      child: Image.asset(
                                                          AppAssets.followBtn),
                                                    ),
                                                  )
                                                : const SizedBox(),
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

                                              exploreController
                                                  .likeValue(index);
                                              print('double tap done');
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
                                                fit: BoxFit.contain,
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
                                                          onTap: () =>
                                                              exploreController
                                                                  .likeValue(
                                                                      index),
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
