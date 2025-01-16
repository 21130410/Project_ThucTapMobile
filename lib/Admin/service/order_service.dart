import 'dart:convert';
import 'package:http/http.dart' as http;
import '../pages/manage_orders_page.dart';

class OrderService {
  final String baseUrl = 'http://localhost:8080/api/orders';

  Future<List<Order>> getAllOrders() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {// In ra nội dung response
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Order.fromJson(item)).toList();
      } else {
        throw Exception('Không thể tải danh sách đơn hàng');
      }
    } catch (e) {
      throw Exception('Lỗi khi kết nối với máy chủ: $e');
    }
  }

  Future<void> addOrder(Order order) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(order.toJson()),
      );
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      if (response.statusCode != 201) {
        throw Exception('Không thể thêm đơn hàng');
      }
    } catch (e) {
      throw Exception('Lỗi khi kết nối với máy chủ: $e');
    }
  }

  Future<void> updateOrder(Order order) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${order.orderId}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(order.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Không thể cập nhật đơn hàng');
      }
    } catch (e) {
      throw Exception('Lỗi khi kết nối với máy chủ: $e');
    }
  }

  Future<void> deleteOrder(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));

      if (response.statusCode != 204) {
        throw Exception('Không thể xóa đơn hàng');
      }
    } catch (e) {
      throw Exception('Lỗi khi kết nối với máy chủ: $e');
    }
  }
}

