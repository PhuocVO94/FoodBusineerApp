import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/controller/popular_product_controller.dart';
import 'package:food_delivery_app/controller/recommendred_product.dart';
import 'package:food_delivery_app/home/main_food_page.dart';
import 'package:food_delivery_app/home/cart_controller.dart';
import 'package:food_delivery_app/helper/dependence.dart' as dep;

Future<void> main() async {
  // 1. Đảm bảo hệ thống Flutter sẵn sàng
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. Nạp toàn bộ Dependencies (Kho, Controller...) và CHỜ nó xong
  await dep.init();

  // 3. Tải dữ liệu ngay khi App khởi động (An toàn nhất)
  // Thay vì để trong widget, ta gọi ngay ở đây để dữ liệu sẵn sàng sớm
  try {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendProductController>().getRecommendedProductList();
    Get.find<CartController>().getCartHistoryList();
  } catch (e) {
    print("Lỗi khi tải dữ liệu ban đầu: $e");
  }

  // 4. Chạy App
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Đây là Widget gốc của ứng dụng
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Delivery App',
      theme: ThemeData(
        // Cài đặt màu sắc chủ đạo
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Mở trang chủ MainFoodPage
      home: const MainFoodPage(),
    );
  }
}