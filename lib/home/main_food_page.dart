// library; // Comment dòng này lại để code chạy ổn định

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
// Import các file cần thiết (Giữ nguyên như bạn cung cấp)
import 'cart_page.dart'; 
import 'package:food_delivery_app/home/foodpagebody.dart';
import 'package:food_delivery_app/home/cart_controller.dart';
import 'package:food_delivery_app/home/profile.dart';
import 'package:food_delivery_app/home/history.dart';
import 'package:food_delivery_app/home/cart_page.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:food_delivery_app/models/FoodModel.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  int _selectedIndex = 0;

  List<Widget> get _pages => const [
    FoodPageBody(),
    History(),
    CartPage(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
    Container(
            margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height45),
            padding:  EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const BigText(text: "Việt Nam", color: AppColors.mainColor),
                    Row(
                      children: const [
                        SmallText(text: "Hồ Chí Minh", color: Colors.black54),
                        Icon(Icons.arrow_drop_down_rounded),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: Dimensions.height45,
                  height: Dimensions.height45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.width15),
                    color: AppColors.mainColor,
                  ),
                  child: const Icon(Icons.search, color: Colors.white),
                ),
              ],
            ),
          ),
          // --- BODY ---
          Expanded(
            child: IndexedStack(index: _selectedIndex, children: _pages),
          ),
        ],



      ),
      // --- BOTTOM NAV ---
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'History'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
        ],
      ),
    );
  }
}

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const IconAndTextWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: Dimensions.font24),
        const SizedBox(width: 5),
        SmallText(text: text, color: AppColors.paraColor),
      ],
    );
  }
}



class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;

  const AppIcon({
    super.key,
    required this.icon,
    this.backgroundColor = const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xFF756d54),
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: backgroundColor,
      ),
      child: Icon(icon, color: iconColor, size: 16),
    );
  }
}