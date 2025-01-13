import 'package:ban_mobile/Utils/Theme/helper_function.dart';
import 'package:ban_mobile/Utils/size/size_custom.dart';
import 'package:ban_mobile/Widgets/Custom_Shaps/Containers/rounded_container.dart';
import 'package:ban_mobile/Widgets/img_rouded/image_rouded.dart';
import 'package:ban_mobile/common/shadows.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../Utils/constants/img_path.dart';
import '../icons/circular_icon.dart';

class ProductCardVertical extends StatelessWidget{
  const ProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final dark = HelperFunction.isDarkMode(context);

  return Container(
    width: 180,
    padding: const EdgeInsets.all(1),
    decoration: BoxDecoration(
      boxShadow: [ShadowStyle.verticalProductShadow],
      borderRadius: BorderRadius.circular(Sizes.productImageRadius),
      color: dark ? Colors.grey : Colors.white70,
    ),
    child: Column(
      children: [
        RoundedContainer(
          height: 180,
          padding: const EdgeInsets.all(Sizes.sm),
          backgroundColor: dark? Colors.black: Colors.white,
          child: Stack(
            children: [
              const RoundedImage(imgUrl: Images.iphonelo,applyImageRadius: true,),
              Positioned(
                top: 12,
                child: RoundedContainer(
                  radius: Sizes.sm,
                  backgroundColor: Colors.yellow.withOpacity(0.8),
                  //tạo padding đối xứng
                //     horizontal: Chỉ định giá trị padding cho hai bên trái và phải.
                // vertical: Chỉ định giá trị padding cho hai bên trên và dưới.
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.sm,vertical: Sizes.xs),
                  child: Text("50%",style: TextStyle(
                    color: Colors.black,fontSize: 10
                  ),),

                ),
              ),
            const  Positioned(
                top: 0,
                  right: 0,
                  child: CircularIcon(icon: Iconsax.heart,color: Colors.red,))
            ],
          ),
        )
      ],
    ),
  );
  }


}
