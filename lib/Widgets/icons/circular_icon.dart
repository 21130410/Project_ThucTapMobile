
import 'package:ban_mobile/Utils/Theme/helper_function.dart';
import 'package:flutter/material.dart';

import '../../Utils/size/size_custom.dart';

class CircularIcon extends StatelessWidget {
  const CircularIcon({
    super.key,
    this.width, this.height,
    this.size = Sizes.lg,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });
  final double?width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor != null ? backgroundColor!
        : HelperFunction.isDarkMode(context)
            ? Colors.black.withOpacity(0.9): Colors.white.withOpacity(0.9),
      ),
      child: IconButton(onPressed: onPressed, icon: Icon(icon,color: color,size: size,)),
    );
  }
}