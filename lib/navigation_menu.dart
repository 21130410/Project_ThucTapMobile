import 'package:ban_mobile/Shop/Screens/Home/home.dart';
import 'package:ban_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
    class NavigationMenu extends StatelessWidget {
      const NavigationMenu({super.key});
    
      @override
      Widget build(BuildContext context) {
        final controller = Get.put(NavigationController());
        return Scaffold(
          bottomNavigationBar: Obx(()=> NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value, //Nó xác định mục nào trong các destination sẽ
              // được đánh dấu là "đã chọn".
              onDestinationSelected: (index) => controller.selectedIndex.value=index,
            // do nó bất biến cố định suốt dong đời nên cần kdl const, thư viện pubs
              destinations: const [
                NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
                NavigationDestination(icon: Icon(Iconsax.shop), label: "Store"),
                NavigationDestination(icon: Icon(Iconsax.bill), label: "Order"),
                NavigationDestination(icon: Icon(Iconsax.profile_2user), label: "Profile"),

            ]),
        ),
          body: Obx(()=> controller.screen[controller.selectedIndex.value])
        );
      }
    }
    class NavigationController extends GetxController{
      final Rx<int> selectedIndex = 0.obs;
      final screen =[
       const HomeScreen(),
        Container(color: Colors.red,),
        Container(color: Colors.blue,),
        Container(color: Colors.pink,)
      ]; // tương đương với List<dynamic> screen = [];
      // List<dynamic> screen1 = [];
    }
    