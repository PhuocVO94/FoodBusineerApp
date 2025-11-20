import 'package:flutter/material.dart';
// Import đúng đường dẫn theo cấu trúc của bạn
import '../models/FoodModel.dart'; 
import '../utils/colors.dart';
import '../widgets/big_text.dart';
import '../widgets/small_text.dart';
import '../widgets/icon_and_text.dart';

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
                  // Đảm bảo food.image là chuỗi URL hợp lệ
                  image: NetworkImage(food.image)
                ),
              ),
            ),
          ),
          // Nút Back và Cart
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
          // Phần nội dung chi tiết (bo tròn đè lên ảnh)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 330,
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tên món và Giá
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: BigText(text: food.name, size: 26)),
                      BigText(text: "\$${food.price.toInt()}", color: AppColors.mainColor, size: 20),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Sao đánh giá
                  Row(
                    children: [
                      Wrap(
                        children: List.generate(5, (index) => Icon(Icons.star, color: AppColors.mainColor, size: 15)),
                      ),
                      SizedBox(width: 10),
                      SmallText(text: "${food.rating}"),
                      SizedBox(width: 10),
                      SmallText(text: "${food.commentsCount} bình luận"),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Các icon thông tin
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconAndTextWidget(icon: Icons.circle_sharp, text: "Normal", iconColor: AppColors.iconColor1),
                      IconAndTextWidget(icon: Icons.location_on, text: food.location, iconColor: AppColors.mainColor),
                      IconAndTextWidget(icon: Icons.access_time_rounded, text: food.time, iconColor: AppColors.iconColor2),
                    ],
                  ),
                  SizedBox(height: 20),
                  BigText(text: "Giới thiệu"),
                  SizedBox(height: 10),
                  // Mô tả chi tiết
                  Expanded(
                    child: SingleChildScrollView(
                      child: SmallText(
                        text: food.description + " " + food.description + " " + food.description, // Giả lập văn bản dài
                        size: 16,
                        color: AppColors.paraColor,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Thanh đặt hàng phía dưới
      bottomNavigationBar: Container(
        height: 100,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Icon(Icons.favorite, color: AppColors.mainColor),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.mainColor),
              child: BigText(text: "Thêm vào giỏ | \$${food.price.toInt()}", color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget Icon tròn nhỏ (dùng cho nút Back)
class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  const AppIcon({Key? key, required this.icon, this.backgroundColor = const Color(0xFFfcf4e4), this.iconColor = const Color(0xFF756d54), this.size = 40}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(size / 2), color: backgroundColor),
      child: Icon(icon, color: iconColor, size: 16),
    );
  }
}