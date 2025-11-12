import 'package:flutter/widgets.dart';

class Dimensions {
  // Biến static để lưu chiều cao tổng của màn hình.
  // Chúng ta phải khởi tạo nó bên ngoài Widget build()
  static double screenHeight = 0;
  static double screenWidth = 0;

  // Chiều cao thiết kế gốc (thường là 683,3 - bạn có thể thay đổi)
  // Dùng giá trị tham khảo từ ảnh
  static const double designHeight = 844; // Giá trị ví dụ cho iPhone 13 Pro
  static const double designWidth = 390; // Giá trị ví dụ cho iPhone 13 Pro


  // --- KHỞI TẠO (Phải gọi trong hàm build() của Main Widget) ---
  // Gọi hàm này để thiết lập screenHeight/screenWidth
  static void init(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }


  // --- KÍCH THƯỚC CHIỀU CAO (HEIGHT) DYNAMIC ---
  // Sử dụng screenHeight để tính toán tỉ lệ (ví dụ: designHeight / 10 = 84.4)

  // Tỉ lệ: Chiều cao thiết kế / Giá trị mong muốn
  // Ví dụ: height10 = 844 / 84.4
  static double height10 = screenHeight / 84.4;
  static double height15 = screenHeight / 56.27; // 844 / 15
  static double height20 = screenHeight / 42.2;  // 844 / 20
  static double height30 = screenHeight / 28.13; // 844 / 30
  static double height45 = screenHeight / 18.76; // 844 / 45


  // --- KÍCH THƯỚC CHIỀU RỘNG (WIDTH) DYNAMIC ---
  // Giống như hình ảnh, bạn dùng cùng tỉ lệ Height cho Width/Padding/Margin.
  // Mặc dù việc tính toán dựa trên screenWidth tốt hơn,
  // nhưng nếu làm theo mẫu, chúng ta dùng tỉ lệ Height:

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


  // --- KÍCH THƯỚC CỤ THỂ KHÁC ---
  // Ví dụ cho chiều cao slider trên trang chính
  static double pageView = screenHeight / 2.64; // Ví dụ: 844 / 2.64 ≈ 320
  static double pageViewContainer = screenHeight / 3.84; // Phần Container bên trong Slider
  static double pageViewTextContainer = screenHeight / 7.03; // Phần Text/Footer của Slider

}