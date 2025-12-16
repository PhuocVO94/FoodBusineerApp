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

  // Icon size
  static double iconSize16 = screenHeight / 52.75;
  static double iconSize24 = screenHeight / 35.17;
  static double iconSize30 = screenHeight / 28.13;
  static double iconSize45 = screenHeight / 18.76;
  static double iconSize60 = screenHeight / 14.07;

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



  // IconCreen

  static double icon24 = screenHeight / 25.7;


//   View Picture
  static double viewPicture = screenHeight / 7.1;
  static double listViewTextContSize = screenHeight / 8.44;



}