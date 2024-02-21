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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 50, vertical: 10), // Adjust padding to fit your design
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
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Nexa',
              color: Colors.white,
              fontSize: 16, // Adjust font size to fit your design
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
