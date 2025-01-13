import 'package:ban_mobile/Shop/Screens/Home/widgets/home_categrories.dart';
import 'package:ban_mobile/Shop/Screens/Home/widgets/promo_slider.dart';
import 'package:ban_mobile/Utils/device/device_utility.dart';
import 'package:ban_mobile/Utils/size/size_custom.dart';
import 'package:ban_mobile/Widgets/appbar/appbar.dart';
import 'package:ban_mobile/Widgets/product_card/product_card_vertical.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../Utils/constants/img_path.dart';
import '../../../Widgets/Custom_Shaps/Containers/circular_container.dart';
import '../../../Widgets/Custom_Shaps/Containers/primary_container.dart';
import '../../../Widgets/Custom_Shaps/curved_edges/curved_edges.dart';
import '../../../Widgets/Custom_Shaps/curved_edges/curved_edges_widget.dart';
import '../../../Widgets/Text/section_heading_widget.dart';
import '../../../Widgets/img_rouded/image_rouded.dart';
import 'widgets/home_appbar.dart';
import '../../../Widgets/product_card/cart_menu_icon.dart';
import '../../../Widgets/search/search_container.dart';
import '../../../Widgets/vertical_image_text/vertical_image_text.dart';
// import '../../../Widgets/search/search_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(
      // body chỉ chứa 1 child ko có children
      // column thì chỉ chứa children{ bên trong đây là các widget, có thể lòng layout vào trong}
      body: SingleChildScrollView(
        // sử dụng widget này cho phép cuộn
        child: Column(
          children: [
          const  PrimaryHeaderContainer(
              child: Column(
                children: [
                  const HomeAppbar(),
                  const SizedBox(
                    height: Sizes.spaceBtwSections,
                  ),
                  const SearchBarContainer(
                    text: 'Nhập từ khóa tìm kiếm',
                  ), 
                  const Padding(
                    padding: const EdgeInsets.only(left: Sizes.defautSpace),
                  child: Column(
                    children: [//overflow: TextOverflow.ellipsis giúp hiển thị ... khi văn bản quá không gian
                      const SectionHeading(title: 'Danh Mục Nổi Bật',showActionButton: false,),
                      const SizedBox(height: Sizes.spaceBtwItems,),
                      const HomeCatergories()

                    ],
                  ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Sizes.defautSpace),
              // thư viện carousel
              child: Column(
                children: [
                  PromoSlider(banners: ["assets/images/categories/iphonelo.jpg","assets/images/categories/iphonelo.jpg","assets/images/categories/iphonelo.jpg","assets/images/categories/iphonelo.jpg"],),
                  ProductCardVertical(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
