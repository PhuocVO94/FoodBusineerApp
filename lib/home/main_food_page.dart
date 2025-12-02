/****
    import 'package:flutter/material.dart'
Day la thu vien chinh chay cho android va ios moi nguoi la chu y su dung thu vien cho chinh xacs
anh co thay doi 1 so thu vien moi nguoi nho doc ky thu vien truoc khi dung
**/
library;

import 'package:flutter/material.dart';
import 'package:food_delivery_app/home/foodpagebody.dart';
import 'package:food_delivery_app/home/profile.dart';
import 'package:food_delivery_app/home/history.dart';
import 'package:food_delivery_app/home/cart.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:food_delivery_app/home/food_detail_page.dart';
import 'package:food_delivery_app/models/FoodModel.dart'; // Nếu cần dùng model ở đây

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
  Cart(),
  Profile(),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 45, bottom: 15),
            padding: const EdgeInsets.only(left: 20, right: 20),
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
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
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
            icon: Icon(Icons.shopping_cart),label: 'Cart',),
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
        // 1. Icon
        Icon(icon, color: iconColor, size: 24),
        // 2. Khoảng cách
        const SizedBox(width: 5),
        // 3. Chữ (Text)
        SmallText(text: text, color: AppColors.paraColor),
      ],
    );
  }
}

class FoodDetailPage extends StatelessWidget {
  final FoodModel food;

  const FoodDetailPage({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // --- ẢNH NỀN ---
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(food.image),
                ),
              ),
            ),
          ),
          // --- CÁC ICON TRÊN ẢNH ---
          Positioned(
            top: 45,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const AppIcon(icon: Icons.arrow_back_ios),
                ),
                const AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
          ),
          // --- PHẦN THÔNG TIN CHI TIẾT (Nền trắng bo tròn) ---
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 330,
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tên và giá
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: BigText(text: food.name, size: 26)),
                      BigText(
                        text: "${food.price.toInt()}đ",
                        color: AppColors.mainColor,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Đánh giá sao và comment
                  Row(
                    children: [
                      Wrap(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            color: AppColors.mainColor,
                            size: 15,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SmallText(text: "${food.rating}"),
                      const SizedBox(width: 10),
                      SmallText(text: "${food.commentsCount} đánh giá"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Các thông số (Thời gian, khoảng cách)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconAndTextWidget(
                        icon: Icons.circle_sharp,
                        text: "Ngon",
                        iconColor: AppColors.iconColor1,
                      ),
                      IconAndTextWidget(
                        icon: Icons.location_on,
                        text: food.location,
                        iconColor: AppColors.mainColor,
                      ),
                      IconAndTextWidget(
                        icon: Icons.access_time_rounded,
                        text: food.time,
                        iconColor: AppColors.iconColor2,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const BigText(text: "Giới thiệu"),
                  const SizedBox(height: 10),
                  // Mô tả (Cuộn được nếu dài)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmallText(
                            text: food.description,
                            size: 16,
                            color: AppColors.paraColor,
                            height: 1.5,
                          ),
                          const SizedBox(height: 20),
                          const BigText(text: "Bình luận từ khách hàng"),
                          const SizedBox(height: 10),
                          // --- DANH SÁCH BÌNH LUẬN ---
                          if (food.userComments.isEmpty)
                            const Text("Chưa có bình luận nào.")
                          else
                            ...food.userComments.map((comment) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.buttonBackgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BigText(
                                          text: comment['user']!,
                                          size: 16,
                                        ),
                                        SmallText(text: comment['date']!),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      comment['content']!,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          const SizedBox(height: 50), // Khoảng trống cuối
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // --- NÚT ĐẶT HÀNG ---
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: const Icon(Icons.favorite, color: AppColors.mainColor),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.mainColor,
              ),
              child: BigText(
                text: "Thêm vào giỏ | ${food.price.toInt()}đ",
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget icon tròn nhỏ dùng cho nút Back
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
