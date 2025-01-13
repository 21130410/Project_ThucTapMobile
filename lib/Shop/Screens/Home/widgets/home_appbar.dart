import 'package:flutter/material.dart';

import '../../../../Widgets/product_card/cart_menu_icon.dart';
import '../../../../Widgets/appbar/appbar.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBarCustomm(
      title: const Column(
        children: [
          Text("Xin chào, chúc bạn một ngày tốt lành",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.grey)),
          Text("Tấn Kiệt thân mến!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white))
        ],
      ),
      actions: [
        CartCounterIcon(iconColor: Colors.white,onPressed: (){})
      ],
    );
  }
}