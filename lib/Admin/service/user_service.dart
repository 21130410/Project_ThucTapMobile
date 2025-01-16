import 'dart:convert';
import 'package:http/http.dart' as http;
import '../pages/manage_users_page.dart';

class UserService {
  final String baseUrl = 'http://localhost:8080/api/users';

  // Lấy danh sách người dùng
  Future<List<User>> getAllUsers() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      // Chuyển đổi dữ liệu JSON thành danh sách người dùng
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Không thể tải người dùng');
    }
  }
  Future<void> createUser(User user) async {
    final body = json.encode(user.toJsonForCreate());
    print('Request body: $body');
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      print("Người dùng đã được tạo thành công");
    } else {
      throw Exception('Không thể tạo người dùng');
    }
  }


  // Cập nhật thông tin người dùng
  Future<void> updateUser(User user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${user.userId}'), // Đảm bảo đúng URL để cập nhật theo userId
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),  // Sử dụng user.toJson() để chuyển thành Map<String, dynamic>
    );
    if (response.statusCode == 200) {
      print("Người dùng đã được cập nhật thành công");
    } else {
      throw Exception('Không thể cập nhật người dùng');
    }
  }

  // Xóa người dùng
  Future<void> deleteUser(int userId) async {
    final response = await http.delete(Uri.parse('$baseUrl/$userId'));
    if (response.statusCode == 204) {
      print("Người dùng đã được xóa thành công");
    } else {
      throw Exception('Không thể xóa người dùng');
    }
  }
}
