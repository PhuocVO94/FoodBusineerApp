import 'package:get/get.dart';
// Import file chứa class CartModel. 
// Dựa trên file bạn gửi, CartModel đang nằm trong cart_controller.dart
import '../home/cart_controller.dart'; 

class HistoryController extends GetxController {
  // Danh sách lưu trữ lịch sử các đơn hàng đã đặt
  // Mỗi phần tử là một Map chứa thông tin: thời gian, trạng thái, tổng tiền, danh sách món
  List<Map<String, dynamic>> historyList = [];

  // Hàm thêm đơn hàng mới vào lịch sử
  // - cartItems: Danh sách các món ăn trong giỏ
  // - orderTime: Thời gian thực lúc bấm Check Out (được truyền từ CartPage)
  void addOrder(List<CartModel> cartItems, {String? orderTime}) {
    // 1. Tính tổng tiền của đơn hàng
    double total = 0;
    for (var item in cartItems) {
      total += (item.price! * item.quantity!);
    }

    // 2. Xác định thời gian đặt hàng
    // Nếu bên CartPage có truyền giờ qua thì dùng, nếu không thì tự lấy giờ hiện tại
    String timeToSave = orderTime ?? DateTime.now().toString().substring(0, 16);

    // 3. Tạo đối tượng đơn hàng (Order)
    Map<String, dynamic> order = {
      'time': timeToSave, 
      'status': "Đang giao hàng", // Trạng thái mặc định ban đầu
      'total': total,
      // Quan trọng: Phải dùng .toList() để tạo bản sao danh sách món ăn,
      // nếu không khi xóa giỏ hàng (clear) thì danh sách trong lịch sử cũng bị mất theo.
      'items': cartItems.map((e) => e).toList(), 
    };

    // 4. Thêm đơn hàng mới vào đầu danh sách (để hiển thị đơn mới nhất lên trên cùng)
    historyList.insert(0, order);
    
    // 5. Cập nhật giao diện (nếu có trang nào đang lắng nghe biến historyList)
    update();
  }
  // ===> THÊM HÀM NÀY: Xóa đơn hàng dựa trên thời gian <===
  void cancelOrder(String orderTime) {
    // Xóa phần tử nào có 'time' trùng với orderTime truyền vào
    historyList.removeWhere((item) => item['time'] == orderTime);
    update(); // Cập nhật lại màn hình
    print("Đã xóa đơn hàng lúc: $orderTime");
  }
}