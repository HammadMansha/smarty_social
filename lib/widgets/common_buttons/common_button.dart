// ignore_for_file: deprecated_member_use

import '../../utils/libraries/app_libraries.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final void Function() onPressed;
  final Color fillColor;
  final Color borderColor;
  final double width;
  final double height;
  final bool isIconShow;
  final Icon buttonIcon;

  // ignore: use_key_in_widget_constructors
  const CommonButton({
    required this.text,
    required this.textStyle,
    required this.onPressed,
    required this.fillColor,
    this.isIconShow = false,
    this.width = 125,
    this.height = 45,
    this.borderColor = Colors.transparent,
    this.buttonIcon = const Icon(
      Icons.camera_alt_outlined,
      color: AppColors.buttonColor,
      size: 20,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        gradient: const LinearGradient(
          end: Alignment.centerRight,
          colors: <Color>[Color(0xff7ec6fe), Color(0xffe634ba)],
        ),
        borderRadius: BorderRadius.circular(35),
      ),
      //color: CommonColor.loginAndSendCodeButtonColor,
      width: width,
      height: height,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
          ),
        ),

        onPressed: onPressed,
        // minWidth: Get.width / 3,
        // height: 42,
        // color: Color.fromRGBO(72, 190, 235, 1),
        color: Colors.transparent,
        child: Text(
          text,
          textScaleFactor: 1.0,
          style: textStyle,
          maxLines: 2,
        ),
      ),
    );
  }
}

class CommonFilterButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final void Function() onPressed;
  final Color fillColor;

  // ignore: use_key_in_widget_constructors
  const CommonFilterButton(
      {required this.text,
      required this.textStyle,
      required this.onPressed,
      required this.fillColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //color: CommonColor.loginAndSendCodeButtonColor,
      width: 125,
      height: 35,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: const BorderSide(
            color: Colors.transparent,
          ),
        ),

        onPressed: onPressed,
        // minWidth: Get.width / 3,
        // height: 42,
        // color: Color.fromRGBO(72, 190, 235, 1),
        color: fillColor ?? Colors.transparent,
        child: Text(
          text,
          textScaleFactor: 1.0,
          style: textStyle,
          maxLines: 2,
        ),
      ),
    );
  }
}
