
import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitle ;
  final void Function()? onPressed;
  const SectionHeading({
    super.key,
    this.textColor,
    this.showActionButton =true,
    required this.title,
    this.buttonTitle = "Xem tất cả",
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: textColor),maxLines:1,overflow: TextOverflow.ellipsis,),
        if(showActionButton) TextButton(onPressed: onPressed, child: Text(buttonTitle)),
      ],
    );
  }
}