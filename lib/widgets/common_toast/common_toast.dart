


import '../../utils/libraries/app_libraries.dart';

class CommonToast {
  static void showToast(String message,{Color color=AppColors.blackColor}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red ,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}