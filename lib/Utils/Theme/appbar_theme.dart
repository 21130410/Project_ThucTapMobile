import 'package:flutter/material.dart';

  class AppBarStyleTheme {
  // Private constructor để ngăn việc khởi tạo instance từ bên ngoài.
  AppBarStyleTheme._();

  // Định nghĩa theme cho AppBar trong giao diện sáng.
  static const lightAppBarTheme = AppBarTheme(
  elevation: 0, // Loại bỏ bóng đổ (shadow) của AppBar.
  centerTitle: false, // Căn lề trái cho tiêu đề (title).
  scrolledUnderElevation: 0, // Không thêm bóng khi nội dung cuộn xuống.
  backgroundColor: Colors.transparent, // Màu nền trong suốt.
  surfaceTintColor: Colors.transparent, // Không áp dụng hiệu ứng ánh sáng bề mặt.
  iconTheme: IconThemeData(
  color: Colors.black, // Màu đen cho các biểu tượng (icons).
  ),
  actionsIconTheme: IconThemeData(
  color: Colors.black, // Màu đen cho các biểu tượng trong `actions`.
  ),
  titleTextStyle: TextStyle(
  fontSize: 18.0, // Kích thước chữ của tiêu đề là 18.
  fontWeight: FontWeight.w600, // Độ dày chữ là semi-bold.
  color: Colors.black, // Màu chữ là đen.
  ),
  );

  static const darkAppBarTheme = AppBarTheme(
      elevation:0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black, ),
      actionsIconTheme: IconThemeData(color: Colors.white,),
      titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black)

  );
 }