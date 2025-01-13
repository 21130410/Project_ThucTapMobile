import 'package:flutter/material.dart';

import '../../../Utils/size/size_custom.dart';

class RoundedContainer extends StatelessWidget {
  final double? width, height;
  final double radius;
  final Widget? child;
  final Color borderColor;
  final Color backgroundColor;
  final bool shadowBorder;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const RoundedContainer({super.key,
    this.width,
    this.height,
    this.radius = Sizes.cardRadiusLg,
    this.child,
    this.borderColor= Colors.white,
    this.backgroundColor = Colors.greenAccent,
    this.shadowBorder=false,
    this.padding,
    this.margin});




  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: shadowBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
