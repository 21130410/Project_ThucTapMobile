
import 'package:ban_mobile/Shop/controller/home_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Utils/constants/img_path.dart';
import '../../../../Utils/size/size_custom.dart';
import '../../../../Widgets/Custom_Shaps/Containers/circular_container.dart';
import '../../../../Widgets/img_rouded/image_rouded.dart';

class PromoSlider extends StatelessWidget {
  final List<String> banners;

  const PromoSlider({
    super.key, required this.banners,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          items:banners.map((url)=> RoundedImage(imgUrl: url,)).toList(), options: CarouselOptions(viewportFraction: 1,
        onPageChanged: (index,_)=>controller.updatePageIndicator(index)),
        ),
        const SizedBox(height: Sizes.spaceBtwItems,),
        Obx(
            ()=> Row(
              mainAxisSize: MainAxisSize.min,
            children: [
              for(int i= 0; i<banners.length;i++) CircularContainer(width: 20,height: 4,margin: const EdgeInsets.only(right: 10),
                backgroundColor: controller.carousalCurrentIndex.value== i ? Colors.black: Colors.grey),

            ],
          ),
        )
      ],
    );
  }
}



