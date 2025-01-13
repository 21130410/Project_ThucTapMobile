import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key,
    this.width=400,
    this.height=400,
    this.radius=400,
    this.padding=0,
    this.child,
    this.backgroundColor=Colors.white38,
    this.margin,
  });
  //dau ? la no the = null neu khong truyen gi
  final double? width;
  final EdgeInsets? margin;
  final double? height;
  final double radius;
  final double padding;
  final Widget? child ;
  final Color backgroundColor;



  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height:  height, margin: margin,
      padding:  EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,

      ),
      child: child,
    );
  }
}