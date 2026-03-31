import 'package:flutter/material.dart';

void main() {
  // Hàm main là điểm bắt đầu của mọi ứng dụng Flutter
  runApp(
    const MainApp(),
  ); // Chạy widget MainApp như là gốc (root) của toàn bộ ứng dụng
}

class MainApp extends StatelessWidget {
  // MainApp là một StatelessWidget (Widget không thay đổi trạng thái)
  const MainApp({super.key}); // Constructor cho widget MainApp

  @override
  Widget build(BuildContext context) {
    // Phương thức build mô tả giao diện người dùng của widget
    return MaterialApp(
      // MaterialApp là widget nền tảng cung cấp các thiết lập về chủ đề, điều hướng
      debugShowCheckedModeBanner: false, // Ẩn biểu tượng "Debug" ở góc màn hình
      home: Scaffold(
        // Scaffold cung cấp cấu trúc khung cơ bản (như AppBar, Body, Drawer)
        body: Center(
          // Center giúp căn giữa các thành phần con vào chính giữa màn hình
          child: Column(
            // Column sắp xếp các widget con theo chiều dọc (từ trên xuống dưới)
            mainAxisAlignment: MainAxisAlignment
                .center, // Căn giữa các thành phần trong cột theo trục dọc
            children: [
              const Text(
                // Widget Text dùng để hiển thị một chuỗi văn bản
                'Welcome to Flutter!',
                style: TextStyle(
                  fontSize: 24, // Cài đặt cỡ chữ là 24
                  fontWeight: FontWeight.bold, // Làm cho chữ đậm lên
                ),
              ),

              // SizedBox tạo ra một khoảng trống có kích thước xác định (để làm giãn cách)
              const SizedBox(height: 16),

              // Hiển thị một biểu tượng Flutter hoặc ảnh từ assets
              // Lưu ý: Đảm bảo bạn đã khai báo assets trong pubspec.yaml
              Image.asset(
                'assets/images/flutter_logo.png',
                width: 200, // Thiết lập chiều rộng của ảnh
                height: 200, // Thiết lập chiều cao của ảnh
                errorBuilder: (context, error, stackTrace) {
                  // Hiển thị icon thay thế nếu không tìm thấy file ảnh
                  return const FlutterLogo(size: 200);
                },
              ),

              const SizedBox(height: 16),

              Container(
                // Container là một widget đa năng dùng để chứa và trang trí
                width: 200, // Chiều rộng khối container
                height: 50, // Chiều cao khối container
                decoration: BoxDecoration(
                  color: Colors.blue, // Đặt màu nền cho khối là màu xanh dương
                  borderRadius: BorderRadius.circular(
                    8,
                  ), // Bo góc cho container
                ),
                child: const Center(
                  // Căn giữa nội dung bên trong Container
                  child: Text(
                    // Hiển thị chữ 'Start' bên trong nút bấm (container)
                    'Start',
                    style: TextStyle(
                      color: Colors.white, // Đặt màu chữ là màu trắng
                      fontSize: 18, // Cỡ chữ cho nút bấm
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
