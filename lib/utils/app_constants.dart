class AppConstants {
  // === PHẦN CODE GỐC CỦA BẠN (GIỮ NGUYÊN) ===
  static const String APP_NAME = "DBFood";
  static const int APP_VERSION = 1;

  static const String BASE_URL = "https://mvs.bslmeiyu.com";
  static const String POPULAR_PRODUCT_URL = "/api/v1/products/popular";


  // === PHẦN CODE MỚI CẦN THÊM VÀO (ĐỂ HẾT LỖI) ===

  // 1. Thêm biến URI (Vì code mới dùng tên URI thay vì URL)
  // Hai dòng này giống nhau về nội dung nhưng khác tên biến để tránh lỗi
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular"; 
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";

  // 2. Đường dẫn thư mục chứa ảnh trên server (Rất quan trọng để hiện ảnh)
  static const String UPLOAD_URL = "/uploads/";

  // 3. Các từ khóa để lưu dữ liệu vào máy (Shared Preferences)
  // Giúp lưu giỏ hàng và lịch sử mua hàng khi tắt app
  static const String TOKEN = "DBtoken";
  static const String PHONE = "";
  static const String PASSWORD = "";
  
  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";
}