import 'package:smarty_social/utils/libraries/app_libraries.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: bodyData(context),
    );
  }

  bodyData(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            SizedBox(
              height: Get.height / 4,
              width: Get.width,
              child: Image.asset(AppAssets.feedUp),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 3,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
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
                              backgroundImage: AssetImage(AppAssets.userDp),
                              radius: 30,
                            ),

                            //user name and time
                            const Column(
                              children: [
                                Text("Ana_Solam"),
                                Text("yesterday"),
                              ],
                            ).marginSymmetric(horizontal: 15),
                            const Spacer(),

                            //Follow button
                            SizedBox(
                              height: 30,
                              child: Image.asset(AppAssets.followBtn),
                            ),
                          ],
                        ).marginSymmetric(horizontal: 20, vertical: 20),

                        //post image
                        Expanded(
                          child: SizedBox(
                            width: Get.width,
                            child: Image.asset(
                              AppAssets.exploreImg,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),

                        //Like button
                        SizedBox(
                          height: 50,
                          width: Get.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: Row(
                                  children: [
                                    Image.asset(AppAssets.like,),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text("234"),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Row(
                                  children: [
                                    Image.asset(AppAssets.comment),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text("133"),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Row(
                                  children: [
                                    Image.asset(AppAssets.view),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text("1145"),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Row(
                                  children: [
                                    Image.asset(AppAssets.share),
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
              ),
            ),
            //const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
