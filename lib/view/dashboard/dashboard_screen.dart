import '../../utils/libraries/app_libraries.dart';

class DashboardScreen extends StatelessWidget with InitializeLocalStorage {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DashboardScreenController(),
      builder: (_) {
        return WillPopScope(
          onWillPop: () async {
            if (_.navigationQueue.isEmpty && storage.hasData("token")) {
              return showWillPopMessage(context, _);
            } else {
              SystemNavigator.pop();
            }

            _.navigationQueue.removeLast();
            int position =
                _.navigationQueue.isEmpty ? 0 : _.navigationQueue.last;
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

  showWillPopMessage(context, DashboardScreenController _) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          title: Center(
            child: Text('Logout?',
                textScaleFactor: 1.0, style: CommonTextStyle.EditProfileFont),
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
                      color: Colors.black,
                      letterSpacing: 0.4,
                      fontFamily: 'Nexa'),
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
                            color: AppColors.blackColor, fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Container(
                      width: Get.width / 3.4,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF808BFF),
                            Color(0xffC135F6), // Start color of the gradient
                            Color(0xFFF431A7), // End color of the gradient
                          ],
                        ),
                        borderRadius: BorderRadius.circular(
                            30), // Adjust border radius to fit your design
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          await _.logoutUser();
                        },
                        child: const Text(
                          "Logout",
                          textScaleFactor: 1.0,
                          style:
                              TextStyle(color: AppColors.white, fontSize: 16),
                        ),
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
