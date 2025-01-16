import 'dart:convert';
import 'package:http/http.dart' as http;

import '../pages/manage_orders_page.dart';

class OrderService {
  final String baseUrl = 'http://localhost:8080/api/orders';

  Future<List<Order>> getAllOrders() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<void> createOrder(Order order) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(order.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create order');
    }
  }

  Future<void> updateOrder(Order order) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${order.orderId}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(order.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update order');
    }
  }

  Future<void> deleteOrder(int orderId) async {
    final response = await http.delete(Uri.parse('$baseUrl/$orderId'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete order');
    }
  }
}
