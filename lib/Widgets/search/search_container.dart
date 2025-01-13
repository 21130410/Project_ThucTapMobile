import 'package:ban_mobile/Utils/Theme/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../Utils/device/device_utility.dart';
import '../../Utils/size/size_custom.dart';

class SearchBarContainer extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;

  const SearchBarContainer({
    super.key,
    required this.text,
    this.icon,
    this.showBackground = true,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    // không ghi kiểu dữ liệu dart sẽ tự suy đoán
    final dark = HelperFunction.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.defautSpace),
      child: Container(
        width: DeviceUtility.getScreenWidth(context),
        padding: const EdgeInsets.all(Sizes.md),
        //(condition) ?(if) valueIfTrue :(else) valueIfFalse;
        //Color color;
        // if (showBackground) {
        //   if (dark) {
        //     color = Colors.black;
        //   } else {
        //     color = Colors.white;
        //   }
        // } else {
        //   color = Colors.transparent;
        // }
        decoration: BoxDecoration(
          color: showBackground
              ? dark
                  ? Colors.black
                  : Colors.white
              : Colors.transparent,
          borderRadius: BorderRadius.circular(Sizes.cardRadiusLg),
          border: showBorder ? Border.all(color: Colors.grey) : null,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: Sizes.spaceBtwItems,
            ),
            Expanded(
                child: TextField(
                    decoration: InputDecoration(
              hintText: 'Nhập từ khóa tìm kiếm',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(Sizes.cardRadiusLg),
              ),
            ))),      IconButton(
              icon: const Icon(
                Iconsax.search_favorite, // Sử dụng icon tìm kiếm từ Iconsax
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
