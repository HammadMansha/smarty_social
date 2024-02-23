import 'dart:io';

import 'package:smarty_social/utils/libraries/app_libraries.dart';
import 'dart:math' as math;

class MenEditingPostScreen extends StatelessWidget {
  const MenEditingPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MenEditingController menEditingController = Get.put(MenEditingController());

    return GetBuilder<MenEditingController>(builder: (_) {
      return CommonScaffold(
        body: bodyData(context),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Obx(() {
            return Text(
              menEditingController.framingDone.value == false
                  ? "Framing"
                  : "Clothing",
              style: CommonTextStyle.font16weight400BlackNexRegular,
            );
          }),
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              size: 20,
              color: AppColors.blackColor,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                if (menEditingController.tapCount == 0) {
                  menEditingController.framingDone.value = true;
                } else if (menEditingController.tapCount == 1) {
                  menEditingController.uploadImageToDb();
                }

                menEditingController.tapCount++;
                if (menEditingController.tapCount > 1) {
                  menEditingController.tapCount = 0;
                }
              },
              child: SizedBox(
                height: 70,
                width: 70,
                child: Image.asset(AppAssets.next),
              ),
            ).marginOnly(right: 20),
          ],
        ),
      );
    });
  }

  bodyData(BuildContext context) {
    return GetBuilder<MenEditingController>(builder: (_) {
      return SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            Expanded(
              child: Transform(
                transform: Matrix4.identity()
                  ..rotateZ(_.rotationAngle * (3.1415926535897932 / 180))
                  ..scale(_.mirror ? -1.0 : 1.0, 1.0),
                alignment: Alignment.center,
                child: Image.file(
                  _.createPostController.image as File,
                  fit: BoxFit.scaleDown,
                ), // Replace 'assets/image.jpg' with your image path
              ),
            ),
            Obx(() {
              return _.framingDone.value == false
                  ? Container(
                      height: 100,
                      width: Get.width,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  _.rotateImage();
                                },
                                child: SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: Image.asset(AppAssets.rotate),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  _.createPostController.image =
                                      await _.cropImage(
                                    imageFile: _.createPostController.image,
                                  );
                                  print(
                                      "====================file===========${_.createPostController.image}");
                                  _.update();
                                }, //                          },
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.crop_square,
                                      color: Colors.black,
                                    ),
                                    Text("Crop",
                                        style: CommonTextStyle
                                            .font16weight400BlackNexRegular),
                                  ],
                                ),
                              ),

                              // SizedBox(
                              //   height: 30,
                              //   width: 30,
                              //   child: Image.asset(AppAssets.ratio),
                              // ),

                              InkWell(
                                onTap: () {
                                  _.toggleMirror();
                                  print(
                                      "Value of X mirror =============${_.mirror}");
                                },
                                child: SizedBox(
                                  height: 23,
                                  width: 23,
                                  child: Image.asset(AppAssets.mirror),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ).marginOnly(left: 25, right: 25, top: 35),
                    )
                  : Container(
                      height: 100,
                      width: Get.width,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              _.selectedNav = "outfits";
                              _.update();

                              await styleBottomSheet(context, _);
                            },
                            child: Image.asset(_.selectedNav == "outfits"
                                ? AppAssets.outfit
                                : AppAssets.menTransOutfit),
                          ),
                          GestureDetector(
                            onTap: () async {
                              _.selectedNav = "style";
                              _.update();
                            },
                            child: Image.asset(_.selectedNav == "style"
                                ? AppAssets.menStyleColor
                                : AppAssets.style),
                          ),
                          GestureDetector(
                            onTap: () async {
                              _.selectedNav = "fitviz";
                              _.update();
                            },
                            child: Image.asset(_.selectedNav == "fitviz"
                                ? AppAssets.menFitvizColor
                                : AppAssets.fitz),
                          ),
                          GestureDetector(
                            onTap: () async {
                              _.selectedNav = "accessories";
                              _.update();
                            },
                            child: Image.asset(_.selectedNav == "accessories"
                                ? AppAssets.blueAccessories
                                : AppAssets.accessories),
                          ),
                          GestureDetector(
                            onTap: () async {
                              _.selectedNav = "filter";
                              _.update();
                            },
                            child: Image.asset(_.selectedNav == "filter"
                                ? AppAssets.blueFilter
                                : AppAssets.filter),
                          ),
                        ],
                      ).marginOnly(left: 25, right: 25, top: 35),
                    );
            }),
          ],
        ),
      );
    });
  }

  //Outfit sheet
  Future<void> styleBottomSheet(
      BuildContext context, MenEditingController _) async {
    Get.bottomSheet(
      backgroundColor: Colors.blue,
      isScrollControlled: true,
      StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: Get.height / 1.3,
            width: Get.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 8,
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.colorC1c1,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.white),
                    ),
                  ),
                ),
                CommonSpaces.spaceVertical20,

                Text(
                  "Select Style",
                  style: CommonTextStyle.font16weight400BlackNexRegular,
                ),

                CommonSpaces.spaceVertical30,

                //Blazers
                InkWell(
                  onTap: () async {
                    _.selectedAsset = "Blazers";
                    setState(() {});
                    await editingSheet(context, _);
                  },
                  child: Container(
                    width: Get.width,
                    height: 75,
                    decoration: BoxDecoration(
                      color: AppColors.colorF7F7,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          AppAssets.blazer,
                          height: 50,
                          width: 50,
                        ).marginOnly(left: 15),
                        Text(
                          "Blazers",
                          style: CommonTextStyle.font16weight400BlackNexRegular,
                        ).marginOnly(left: 15)
                      ],
                    ),
                  ),
                ),

                CommonSpaces.spaceVertical10,

                //Suits
                InkWell(
                  onTap: () async {
                    _.selectedAsset = "Suits";
                    setState(() {});
                    await editingSheet(context, _);
                  },
                  child: Container(
                    width: Get.width,
                    height: 75,
                    decoration: BoxDecoration(
                        color: AppColors.colorF7F7,
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        Image.asset(
                          AppAssets.suits,
                          height: 50,
                          width: 50,
                        ).marginOnly(left: 15),
                        Text(
                          "Suits",
                          style: CommonTextStyle.font16weight400BlackNexRegular,
                        ).marginOnly(left: 15)
                      ],
                    ),
                  ),
                ),
                CommonSpaces.spaceVertical10,

                //Dress Shirt
                InkWell(
                  onTap: () async {
                    _.selectedAsset = "Dress Shirt";
                    setState(() {});
                    await editingSheet(context, _);
                  },
                  child: Container(
                    width: Get.width,
                    height: 75,
                    decoration: BoxDecoration(
                        color: AppColors.colorF7F7,
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        Image.asset(
                          AppAssets.dressShirt,
                          height: 50,
                          width: 50,
                        ).marginOnly(left: 15),
                        Text(
                          "Dress Shirt",
                          style: CommonTextStyle.font16weight400BlackNexRegular,
                        ).marginOnly(left: 15)
                      ],
                    ),
                  ),
                ),
                CommonSpaces.spaceVertical10,

                //Sweat Shirt
                InkWell(
                  onTap: () async {
                    _.selectedAsset = "Sweat Shirt";
                    setState(() {});
                    await editingSheet(context, _);
                  },
                  child: Container(
                    width: Get.width,
                    height: 75,
                    decoration: BoxDecoration(
                        color: AppColors.colorF7F7,
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        Image.asset(
                          AppAssets.sweatShirt,
                          height: 50,
                          width: 50,
                        ).marginOnly(left: 15),
                        Text(
                          "Sweat Shirt",
                          style: CommonTextStyle.font16weight400BlackNexRegular,
                        ).marginOnly(left: 15)
                      ],
                    ),
                  ),
                ),
                CommonSpaces.spaceVertical10,

                //Traditional
                InkWell(
                  onTap: () async {
                    _.selectedAsset = "Traditional";
                    setState(() {});
                    await editingSheet(context, _);
                  },
                  child: Container(
                    width: Get.width,
                    height: 75,
                    decoration: BoxDecoration(
                      color: AppColors.colorF7F7,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          AppAssets.dressShirt,
                          height: 50,
                          width: 50,
                        ).marginOnly(left: 15),
                        Text(
                          "Dress Shirt",
                          style: CommonTextStyle.font16weight400BlackNexRegular,
                        ).marginOnly(left: 15)
                      ],
                    ),
                  ),
                ),
                CommonSpaces.spaceVertical10,

                //Jacket
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: Get.width,
                    height: 75,
                    decoration: BoxDecoration(
                        color: AppColors.colorF7F7,
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        Image.asset(
                          AppAssets.traditional,
                          height: 50,
                          width: 50,
                        ).marginOnly(left: 15),
                        Text(
                          "Traditional",
                          style: CommonTextStyle.font16weight400BlackNexRegular,
                        ).marginOnly(left: 15)
                      ],
                    ),
                  ),
                ),
                CommonSpaces.spaceVertical10,
              ],
            ).marginSymmetric(horizontal: 10),
          );
        },
      ),
    );
  }

  //styling assets sheet
  Future<void> editingSheet(
      BuildContext context, MenEditingController _) async {
    Get.bottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      StatefulBuilder(builder: (context, setState) {
        return Container(
          height: Get.height / 1.3,
          width: Get.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50, // Adjust height as needed
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _.assetType.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              _.selectedAsset = _.assetType[index];
                              setState(() {});
                            },
                            child: Center(
                              child: Text(
                                _.assetType[index],
                                style: _.selectedAsset == _.assetType[index]
                                    ? CommonTextStyle.font16weightBold3166
                                    : CommonTextStyle
                                        .font16weight400BlackNexRegular,
                              ),
                            ).marginSymmetric(horizontal: 10),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ).marginOnly(top: 15),
              Expanded(
                child: _.selectedAsset == "Blazers"
                    ? blazerAssets(context, _)
                    : _.selectedAsset == "Suits"
                        ? suitsAssets(context, _)
                        : _.selectedAsset == "Dress Shirt"
                            ? dressShirt(context, _)
                            : _.selectedAsset == "Sweat Shirt"
                                ? sweatShirt(context, _)
                                : _.selectedAsset == "Traditional"
                                    ? traditionalShirt(context, _)
                                    : const SizedBox(),
              ),
            ],
          ).marginSymmetric(horizontal: 10),
        );
      }),
    );
  }

  //Blazer Assets
  Widget blazerAssets(BuildContext context, MenEditingController _) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            mainAxisExtent: 250,
          ),
          itemCount: 10,
          itemBuilder: (_, index) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.colorD9d9d9,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset(AppAssets.download),
                  ),
                ).marginOnly(bottom: 5, right: 5),
              ],
            );
          }),
    );
  }

  //Suits
  Widget suitsAssets(BuildContext context, MenEditingController _) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            mainAxisExtent: 250,
          ),
          itemCount: 10,
          itemBuilder: (_, index) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.colorD9d9d9,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset(AppAssets.download),
                  ),
                ).marginOnly(bottom: 5, right: 5),
              ],
            );
          }),
    );
  }

  //Dress Shirt
  Widget dressShirt(BuildContext context, MenEditingController _) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            mainAxisExtent: 250,
          ),
          itemCount: 10,
          itemBuilder: (_, index) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.colorD9d9d9,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset(AppAssets.download),
                  ),
                ).marginOnly(bottom: 5, right: 5),
              ],
            );
          }),
    );
  }

  //Sweat Shirt
  Widget sweatShirt(BuildContext context, MenEditingController _) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            mainAxisExtent: 250,
          ),
          itemCount: 10,
          itemBuilder: (_, index) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.colorD9d9d9,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset(AppAssets.download),
                  ),
                ).marginOnly(bottom: 5, right: 5),
              ],
            );
          }),
    );
  }

  //Traditional Shirt
  Widget traditionalShirt(BuildContext context, MenEditingController _) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            mainAxisExtent: 250,
          ),
          itemCount: 10,
          itemBuilder: (_, index) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.colorD9d9d9,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset(AppAssets.download),
                  ),
                ).marginOnly(bottom: 5, right: 5),
              ],
            );
          }),
    );
  }
}
