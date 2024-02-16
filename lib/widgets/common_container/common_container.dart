import 'package:smarty_social/utils/libraries/app_libraries.dart';

class CommonContainer extends StatelessWidget {
  Key? key;
  AlignmentGeometry? alignment;
  EdgeInsetsGeometry? padding;
  Color? color=Colors.white;
  Decoration? decoration;
  Decoration? foregroundDecoration;
  double? width=Get.width;
  double? height=Get.height;
  BoxConstraints? constraints;
  EdgeInsetsGeometry? margin;
  Matrix4? transform;
  AlignmentGeometry? transformAlignment;
  Widget? child;
  Clip clipBehavior = Clip.none;

  CommonContainer(
      {super.key,
      this.width,
      this.height,
      this.alignment,
      this.child,
      this.clipBehavior = Clip.none,
      this.color,
      this.constraints,
      this.decoration,
      this.foregroundDecoration,
      this.margin,
      this.padding,
      this.transform,
      this.transformAlignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      key: key,
      decoration: decoration,
      alignment: alignment,
      clipBehavior: clipBehavior,
      constraints: constraints,
      foregroundDecoration: foregroundDecoration,
      margin: margin,
      padding: padding,
      transform: transform,
      transformAlignment: transformAlignment,
      color: color,
      child: child,
    );
  }
}
