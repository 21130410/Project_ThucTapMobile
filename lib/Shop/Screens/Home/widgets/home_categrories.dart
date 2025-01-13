
import 'package:flutter/material.dart';

import '../../../../Utils/constants/img_path.dart';
import '../../../../Widgets/vertical_image_text/vertical_image_text.dart';

class HomeCatergories extends StatelessWidget {
  const HomeCatergories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return const VerticalImageText(image: Images.launcher, title: "Iphone", textColor: Colors.white,);
        },
        
      ),
    );
  }
}