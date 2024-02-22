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
                            Column(
                              children: [
                                Text(
                                  "Ana_Solam",
                                  style: CommonTextStyle.font14weightNormal342f,
                                ).marginOnly(left: 15),
                                Text(
                                  "Yesterday",
                                  style: CommonTextStyle.font12weightNormal342f,
                                ),
                              ],
                            ),
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
                                    const SizedBox(
                                        child: Icon(Icons.favorite,size: 24,color: AppColors.blackColor,)

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
              ),
            ),
            //const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
