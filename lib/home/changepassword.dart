import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  // biến để điều khiển ẩn/hiện
  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Đổi mật khẩu")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Mật khẩu hiện tại
            TextField(
              controller: oldPassController,
              obscureText: _obscureOld,
              decoration: InputDecoration(
                labelText: "Mật khẩu hiện tại",
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureOld ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureOld = !_obscureOld;
                    });
                  },
                ),
              ),
            ),

            // Mật khẩu mới
            TextField(
              controller: newPassController,
              obscureText: _obscureNew,
              decoration: InputDecoration(
                labelText: "Mật khẩu mới",
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureNew ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureNew = !_obscureNew;
                    });
                  },
                ),
              ),
            ),

            // Xác nhận mật khẩu mới
            TextField(
              controller: confirmPassController,
              obscureText: _obscureConfirm,
              decoration: InputDecoration(
                labelText: "Xác nhận mật khẩu mới",
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirm = !_obscureConfirm;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor),
              onPressed: () {
                if (newPassController.text == confirmPassController.text) {
                  // TODO: gọi API đổi mật khẩu
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Đổi mật khẩu thành công")),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Mật khẩu xác nhận không khớp")),
                  );
                }
              },
              child: const Text(
                "Xác nhận",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
