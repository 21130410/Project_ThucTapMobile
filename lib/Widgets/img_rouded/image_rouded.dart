import 'package:flutter/material.dart';

import '../../Utils/constants/img_path.dart';
import '../../Utils/size/size_custom.dart';

class RoundedImage extends StatelessWidget {
  final double? width, height;
  final String imgUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  const RoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imgUrl,
    this.applyImageRadius = false,
    this.border,
    this.backgroundColor = Colors.white,
    this.fit,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = Sizes.md,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(Sizes.md)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.md),
            child:  Image(image: AssetImage(imgUrl)),
          )),
    );
  }
}
