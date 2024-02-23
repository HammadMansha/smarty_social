import 'dart:io';
import 'package:smarty_social/controller/editing/women_editing/women_editing_controller.dart';
import 'package:smarty_social/utils/libraries/app_libraries.dart';

class WomenEditingPostScreen extends StatelessWidget {
  const WomenEditingPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WomenEditingController womenEditingController =
        Get.put(WomenEditingController());
    return CommonScaffold(
      body: bodyData(context, womenEditingController),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Obx(() {
          return Text(
            womenEditingController.framingDone.value == false
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
              if (womenEditingController.tapCount == 0) {
                womenEditingController.framingDone.value = true;
              } else if (womenEditingController.tapCount == 1) {
                womenEditingController.uploadImageToDb();
              }

              womenEditingController.tapCount++;
              if (womenEditingController.tapCount > 1) {
                womenEditingController.tapCount = 0;
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
  }

  bodyData(
      BuildContext context, WomenEditingController womenEditingController) {
    return GetBuilder<WomenEditingController>(builder: (_) {
      return SizedBox(
        height: Get.height,
        width: Get.width,
        child: _.isLoading.value == true
            ? const Center(
                child: AppLoader(),
              )
            : Column(
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
                    return womenEditingController.framingDone.value == false
                        ? Container(
                            height: 100,
                            width: Get.width,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          imageFile:
                                              _.createPostController.image,
                                        );
                                        print(
                                            "====================file===========${_.createPostController.image}");
                                        _.update();
                                      },
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
                                    _.selectedNav = "outfit";
                                    _.update();
                                    await styleBottomSheet(context, _);
                                  },
                                  child: Image.asset(_.selectedNav == "outfit"
                                      ? AppAssets.womenOutfit
                                      : AppAssets.womenOutfitTrans),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _.selectedNav = "style";
                                    _.update();
                                  },
                                  child: Image.asset(_.selectedNav == "style"
                                      ? AppAssets.womenStyleColor
                                      : AppAssets.womenStyle),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _.selectedNav = "fitviz";
                                    _.update();
                                  },
                                  child: Image.asset(_.selectedNav == "fitviz"
                                      ? AppAssets.womenFitvizColor
                                      : AppAssets.womenFitViz),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _.selectedNav = "accessories";
                                    _.update();
                                  },
                                  child: Image.asset(
                                      _.selectedNav == "accessories"
                                          ? AppAssets.pinkAccessories
                                          : AppAssets.accessories),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    _.selectedNav = "filter";
                                    _.update();
                                    await filtersSheet(context, _);
                                  },
                                  child: Image.asset(_.selectedNav == "filter"
                                      ? AppAssets.pinkFilter
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
      BuildContext context, WomenEditingController _) async {
    Get.bottomSheet(
      backgroundColor: Colors.blue,
      isScrollControlled: true,
      StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: Get.height / 1.8,
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
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          AppAssets.womenSuits,
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

                //Weeding outfits
                InkWell(
                  onTap: () async {
                    _.selectedAsset = "Weeding Outfits";
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
                          AppAssets.weedingOutfit,
                          height: 50,
                          width: 50,
                        ).marginOnly(left: 15),
                        Text(
                          "Weeding Outfits",
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
                    _.selectedAsset = "Skirts";
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
                          AppAssets.skirts,
                          height: 50,
                          width: 50,
                        ).marginOnly(left: 15),
                        Text(
                          "Skirts",
                          style: CommonTextStyle.font16weight400BlackNexRegular,
                        ).marginOnly(left: 15)
                      ],
                    ),
                  ),
                ),
                CommonSpaces.spaceVertical10,

                //Sarrees
                InkWell(
                  onTap: () async {
                    _.selectedAsset = "Sarrees";
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
                          AppAssets.sarrees,
                          height: 50,
                          width: 50,
                        ).marginOnly(left: 15),
                        Text(
                          "Sarrees",
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

  //styling assets sheet open on click
  Future<void> editingSheet(
      BuildContext context, WomenEditingController _) async {
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
                        itemCount: _.womenAssetType.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              _.selectedAsset = _.womenAssetType[index];
                              setState(() {});
                            },
                            child: Center(
                              child: Text(
                                _.womenAssetType[index],
                                style:
                                    _.selectedAsset == _.womenAssetType[index]
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
                child: _.selectedAsset == "Suits"
                    ? suitsAssets(context, _)
                    : _.selectedAsset == "Weeding Outfits"
                        ? weedingOutfitAssets(context, _)
                        : _.selectedAsset == "Skirts"
                            ? skirt(context, _)
                            : _.selectedAsset == "Sarrees"
                                ? sarrees(context, _)
                                : const SizedBox(),
              ),
            ],
          ).marginSymmetric(horizontal: 10),
        );
      }),
    );
  }

  //Blazer Assets
  Widget suitsAssets(BuildContext context, WomenEditingController _) {
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
  Widget weedingOutfitAssets(BuildContext context, WomenEditingController _) {
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
  Widget skirt(BuildContext context, WomenEditingController _) {
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
  Widget sarrees(BuildContext context, WomenEditingController _) {
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

  Future<void> filtersSheet(
      BuildContext context, WomenEditingController _) async {
    Get.bottomSheet(
        backgroundColor: Colors.blue,
        isScrollControlled: true,
        persistent: true, StatefulBuilder(builder: (context, setState) {
      return Container(
        height: Get.height / 4,
        width: Get.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Column(
              children: [
                const Text(
                  'Hello',
                  style: TextStyle(color: Colors.black),
                ).marginOnly(right: 10),
                Container(
                  margin: EdgeInsets.only(right: index != 9 ? 16.0 : 0.0),
                  height: 76,
                  width: 62,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  // Adjust the height as needed
                ).marginOnly(left: 10),
              ],
            );
          },
        ).marginOnly(top: 30),
      );
    }));
  }
}
