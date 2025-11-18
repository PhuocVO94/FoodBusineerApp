import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Dimensions {
  // Biến static để lưu chiều cao tổng của màn hình.
  // Chúng ta phải khởi tạo nó bên ngoài Widget build()
  static double screenHeight = Get.context!.height;
  static double screenWidth =  Get.context!.width;


  static double viewPage = screenHeight /2.64;
  static double viewPageContainer = screenHeight /3.84;
  static double viewPageTextContainer = screenHeight /7.03;


  static double height10 = screenHeight / 84.4;
  static double height15 = screenHeight / 56.27; // 844 / 15
  static double height20 = screenHeight / 42.2;  // 844 / 20
  static double height30 = screenHeight / 28.13; // 844 / 30
  static double height45 = screenHeight / 18.76; // 844 / 45


  // --- KÍCH THƯỚC CHIỀU RỘNG (WIDTH) DYNAMIC ---
  // Giống như hình ảnh, bạn dùng cùng tỉ lệ Height cho Width/Padding/Margin.
  // Mặc dù việc tính toán dựa trên screenWidth tốt hơn,
  // nhưng nếu làm theo mẫu, chúng ta dùng tỉ lệ Height:

  static double width5 = screenHeight / 168.8;
  static double width10 = screenHeight / 84.4;
  static double width15 = screenHeight / 56.27;
  static double width20 = screenHeight / 42.2;
  static double width30 = screenHeight / 28.13;


  // --- FONT DYNAMIC ---
  static double font12 = screenHeight / 70.33;
  static double font16 = screenHeight / 52.75;
  static double font20 = screenHeight / 42.2;
  static double font24 = screenHeight / 35.16;


  // --- RADIUS DYNAMIC ---
  static double radius15 = screenHeight / 56.27;
  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.13;




// --- TOP LEFT RIGT BOTTOM ----
  static double top5 = screenHeight / 168.8;
  static double top10 = screenHeight / 84.4;
  static double top15 = screenHeight / 56.27;
  static double top20 = screenHeight / 42.2;
  static double top30 = screenHeight / 28.13;
  static double top45 = screenHeight / 18.75;





}