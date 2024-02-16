import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:smarty_social/utils/libraries/app_libraries.dart';

class DashboardScreenController extends GetxController
    with CommonVariables, InitializeLocalStorage {
  ListQueue<int> navigationQueue = ListQueue();
  int currentIndex = 0;
  // late Map<Permission, PermissionStatus> statuses;
  late PersistentTabController controller;

  List<Widget> buildScreens() {
    return [
      const ExploreScreen(),
      const CreatePostScreen(),
      //const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(AppAssets.exploreNav),
        title: ("Explore"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        contentPadding: 7.0,
      ),

      PersistentBottomNavBarItem(
        icon: Image.asset(AppAssets.createNav),
        title: ("Create"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        contentPadding: 7.0,
      ),

      // PersistentBottomNavBarItem(
      //   icon: Image.asset(AppAssets.profileNav),
      //   title: ("Profile"),
      //   activeColorPrimary: CupertinoColors.activeBlue,
      //   inactiveColorPrimary: CupertinoColors.systemGrey,
      //   contentPadding: 7.0,
      //
      // ),
    ];
  }

  @override
  void onInit() {
    //requestPermissions();
    controller = PersistentTabController(initialIndex: 0);

    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: implement onReady

    super.onReady();
  }

  //-----------------All permissions request---------------
  // void requestPermissions() async {
  //   statuses = await [
  //     Permission.location,
  //     Permission.camera,
  //     Permission.storage,
  //   ].request();
  //
  //   statuses.forEach((permission, status) {
  //     if (status.isDenied) {
  //       //openSettings();
  //     }
  //   });
  //   // Process the permission statuses
  //   // ...
  // }

  //------------------------Open Application permission setting screen--------------------
  // void openSettings() async {
  //   await openAppSettings().then((value) => onSettingsScreenClosed());
  // }

//-------------------When user close the app setting page------------
  void onSettingsScreenClosed() {
    // This function will be called when the user comes back from the settings screen
    // Implement your desired logic here
  }

//Change bottom nav bar index
  void changeTabIndex(int index) {
    currentIndex = index;

    if (index == currentIndex) {
      navigationQueue.clear();
      // navigationQueue.removeWhere((element) => element == index);
      navigationQueue.addLast(index);
      currentIndex = index;
      update();
    }
    update();
  }
}
