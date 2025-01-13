
import 'package:flutter/material.dart';

import '../../Utils/size/size_custom.dart';

class VerticalImageText extends StatelessWidget {
  final String image,title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? ontap;

  const VerticalImageText({
    super.key,
    required this.image,
    required this.title,
    required this.textColor,
    this.backgroundColor= Colors.white,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(right: Sizes.spaceBtwItems),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(Sizes.md),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Image(image: AssetImage(image),),
              ),
            ),
            const SizedBox(height: Sizes.spaceBtwItems/2),
            SizedBox(
              width: 55,
              child: Text(title,style: TextStyle(
                  fontSize: 10,fontWeight: FontWeight.bold,color: textColor
              ),maxLines: 1,overflow: TextOverflow.ellipsis,),
            )
          ],
        ),
      ),
    );
  }
}