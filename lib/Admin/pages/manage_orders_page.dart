import 'package:flutter/material.dart';
import '../service/order_service.dart';

class Order {
  int orderId;
  int customerId;
  String orderDate;
  double totalPrice;
  String status;

  Order({
    required this.orderId,
    required this.customerId,
    required this.orderDate,
    required this.totalPrice,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      customerId: json['customerId'],
      orderDate: json['orderDate'],
      totalPrice: json['totalPrice'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'customerId': customerId,
      'orderDate': orderDate,
      'totalPrice': totalPrice,
      'status': status,
    };
  }
}

class ManageOrdersPage extends StatefulWidget {
  const ManageOrdersPage({super.key});

  @override
  State<ManageOrdersPage> createState() => _ManageOrdersPageState();
}

class _ManageOrdersPageState extends State<ManageOrdersPage> {
  final OrderService _orderService = OrderService();
  List<Order> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    try {
      final data = await _orderService.getAllOrders();
      setState(() {
        orders = data;
      });
    } catch (e) {
      print("Error fetching orders: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý đơn hàng')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Đơn hàng ${order.orderId}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ngày đặt: ${order.orderDate}'),
                  Text('Tổng giá: ${order.totalPrice}'),
                  Text('Trạng thái: ${order.status}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
