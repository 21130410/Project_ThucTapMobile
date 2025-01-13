import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../Utils/device/device_utility.dart';
import '../../Utils/size/size_custom.dart';

class AppBarCustomm extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool showBackArrow;  // Kiểm tra xem có muốn hiển thị mũi tên quay lại không
  final IconData? leadingIcon; // Biểu tượng đầu
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final Color backgroundColor;

  const AppBarCustomm({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
    this.backgroundColor = Colors.transparent
  });




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(onPressed: () => Get.back(), icon: const Icon(Iconsax.arrow_left))
            : leadingIcon != null ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon)) : null,
        title: title,
        actions: actions,
        backgroundColor: backgroundColor,

      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtility.getAppBarHeight());
}
