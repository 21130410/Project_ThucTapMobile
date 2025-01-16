import 'dart:convert';
import 'package:http/http.dart' as http;

import '../pages/manage_products_page.dart';

class ProductService {
  final String baseUrl = 'http://localhost:8080/api/products';

  // Lấy danh sách sản phẩm
  Future<List<Product>> getAllProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Không thể tải sản phẩm');
    }
  }

  // Thêm sản phẩm mới
  Future<void> addProduct(Product product) async {
    final body = jsonEncode(product.toJsonForCreate());
    print('Request body: $body');

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      print("Sản phẩm đã được thêm thành công");
    } else {
      throw Exception('Không thể thêm sản phẩm');
    }
  }

  // Cập nhật thông tin sản phẩm
  Future<void> updateProduct(Product product) async {
    final body = jsonEncode(product.toJson());
    print('Request body: $body');

    final response = await http.put(
      Uri.parse('$baseUrl/${product.productId}'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      print("Sản phẩm đã được cập nhật thành công");
    } else {
      throw Exception('Không thể cập nhật sản phẩm');
    }
  }

  // Xóa sản phẩm
  Future<void> deleteProduct(int productId) async {
    final response = await http.delete(Uri.parse('$baseUrl/$productId'));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 204) {
      print("Sản phẩm đã được xóa thành công");
    } else {
      throw Exception('Không thể xóa sản phẩm');
    }
  }
}
