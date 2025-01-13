
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CartCounterIcon extends StatelessWidget {
  const CartCounterIcon({
    super.key, required this.iconColor, required this.onPressed,
  });
  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(onPressed: (){}, icon: const Icon(Iconsax.shopping_bag),color: Colors.black,),
        Positioned(right:0,
            child: Container(
              width: 18,
              height: 18,
              decoration:BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(100)
              ),
              child: const Center(
                child: Text("5",style:TextStyle( fontWeight: FontWeight.bold,color: Colors.white) ,),
              ),
            ))
      ],

    );
  }
}
