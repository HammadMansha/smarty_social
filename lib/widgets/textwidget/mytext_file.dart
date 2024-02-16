import 'package:flutter/material.dart';

class CommonTextStyle extends StatelessWidget {
  final String text;
  final double? fontSize;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final FontWeight? fontWeight;
  final Color? color;
  final bool upperCase;
  final double letterSpacing;
  final TextDecoration? decoration;
  final TextOverflow? overflow;

  const CommonTextStyle(
    this.text, {
    this.upperCase = false,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.color,
    this.style,
    this.fontWeight,
    this.letterSpacing = 0,
    this.decoration,
    this.overflow,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(upperCase ? text.toUpperCase() : text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
            letterSpacing: letterSpacing,
            fontSize: fontSize ?? 12,
            color: color ?? Colors.black,
            decoration: decoration,
            fontWeight: fontWeight ?? FontWeight.normal,
            fontFamily: 'Nexa'));
  }
}
