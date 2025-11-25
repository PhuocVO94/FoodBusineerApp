import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Đổi mật khẩu")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: oldPassController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Mật khẩu hiện tại"),
            ),
            TextField(
              controller: newPassController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Mật khẩu mới"),
            ),
            TextField(
              controller: confirmPassController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Xác nhận mật khẩu mới"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 137, 218, 208)),
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
              child: const Text("Xác nhận"),
            ),
          ],
        ),
      ),
    );
  }
}
