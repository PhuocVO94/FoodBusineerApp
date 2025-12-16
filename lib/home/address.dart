import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  List<Map<String, String>> addresses = [
    {
      'name': 'Nhà riêng',
      'detail': '390 Hoàng Văn Thụ, Quận Tân Bình, TP.HCM',
    },
    {
      'name': 'Công ty',
      'detail': '391 Hoàng Văn Thụ, Quận Tân Bình, TP.HCM',
    },
  ];

  // Hàm thêm , chỉnh sửa
  void showAddressDialog({Map<String, String>? current, int? index}) {
    final nameController = TextEditingController(text: current?['name'] ?? "");
    final detailController = TextEditingController(text: current?['detail'] ?? "");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(current == null ? "Thêm địa chỉ mới" : "Chỉnh sửa địa chỉ"),
          content: SizedBox(
            height: 150,
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Tên địa chỉ"),
                ),
                TextField(
                  controller: detailController,
                  decoration: const InputDecoration(labelText: "Chi tiết"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Hủy"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text("Lưu"),
              onPressed: () {
                setState(() {
                  if (current == null) {
                    // thêm mới
                    addresses.add({
                      'name': nameController.text,
                      'detail': detailController.text,
                    });
                  } else {
                    // chỉnh sửa
                    addresses[index!] = {
                      'name': nameController.text,
                      'detail': detailController.text,
                    };
                  }
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // Hàm xác nhận xóa
  void confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Xóa địa chỉ"),
          content: Text("Bạn có chắc muốn xóa địa chỉ '${addresses[index]['name']}' không?"),
          actions: [
            TextButton(
              child: const Text("Hủy"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text("Xoá",style: TextStyle(color: Colors.white,),),
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 137, 218, 208)),
              onPressed: () {
                setState(() {
                  addresses.removeAt(index);
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Địa chỉ giao hàng")),
      body: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          final addr = addresses[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.location_on, color: Colors.redAccent),
              title: Text(addr['name']!),
              subtitle: Text(addr['detail']!),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Color.fromARGB(255, 137, 218, 208)),
                    onPressed: () {
                      showAddressDialog(current: addr, index: index);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Color.fromARGB(255, 137, 218, 208)),
                    onPressed: () {
                      confirmDelete(index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddressDialog(); // thêm mới
        },
        child: const Icon(Icons.add, color:Colors.white),
        backgroundColor: AppColors.mainColor,
      ),
    );
  }
}
