import 'dart:io';
import '../../utils/libraries/app_libraries.dart';

class DashboardScreen extends StatelessWidget  with InitializeLocalStorage{
   DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DashboardScreenController(),
      builder: (_) {
        return WillPopScope(
          onWillPop: () async {
            if (_.navigationQueue.isEmpty && storage.hasData("token")) {
              return showWillPopMessage(context,_);
            }
            else{
              SystemNavigator.pop();
            }

            _.navigationQueue.removeLast();
            int position = _.navigationQueue.isEmpty ? 0 : _.navigationQueue.last;
            _.currentIndex = position;
            _.update();
            return false;
          },
          child: CommonScaffold(
            bottomNavigationBar: bottomNavbar(_, context),
          ),
        );
      },
    );
  }

  showWillPopMessage(context,DashboardScreenController _) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.colorA5A5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          title: const Text(
            'Logout?',
            textScaleFactor: 1.0,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              letterSpacing: 0.4,
              fontFamily: 'Roboto',
            ),
          ),
          content: SizedBox(
            height: 100.0,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Are you sure you want to logout App?',
                  textScaleFactor: 1.0,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      letterSpacing: 0.4,
                      fontFamily: 'Roboto'),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0)),
                      onPressed: () async {
                        Get.back();
                      },
                      minWidth: Get.width / 3.5,
                      height: 48,
                      child: const Text(
                        "Cancel",
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            color: AppColors.buttonColor, fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0),
                        side: const BorderSide(
                          color: AppColors.buttonColor,
                        ),
                      ),
                      onPressed: () async {
                       await _.logoutUser();
                      },
                      minWidth: Get.width / 3.4,
                      height: 40,
                      color: AppColors.buttonColor,
                      child: const Text(
                        "Logout",
                        textScaleFactor: 1.0,
                        style: TextStyle(color: AppColors.white, fontSize: 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget bottomNavbar(DashboardScreenController _, BuildContext context) {
    return PersistentTabView(
      navBarHeight: 65,
      context,
      controller: _.controller,
      screens: _.buildScreens(),
      items: _.navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}
