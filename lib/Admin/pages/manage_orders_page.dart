import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  Map<String, dynamic> toJsonForCreate() {
    return {
      'customerId': customerId,
      'orderDate': orderDate,
      'totalPrice': totalPrice,
      'status': status,
    };
  }
}

class ManageOrdersPage extends StatefulWidget {
  const ManageOrdersPage({Key? key}) : super(key: key);

  @override
  State<ManageOrdersPage> createState() => _ManageOrdersPageState();
}

class _ManageOrdersPageState extends State<ManageOrdersPage> {
  final OrderService _orderService = OrderService();
  List<Order> orders = [];
  bool isLoading = true;

  // Controllers
  final _formKey = GlobalKey<FormState>();
  final TextEditingController customerIdController = TextEditingController();
  final TextEditingController orderDateController = TextEditingController();
  final TextEditingController totalPriceController = TextEditingController();
  final TextEditingController createAtController = TextEditingController();
  String? selectedStatus;
  List<String> statuses = ["Đang xử lý", "Đã hoàn thành", "Đã hủy"];

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  // Fetch orders from service
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

  // Edit order
  void _editOrder(Order order) {
    customerIdController.text = order.customerId.toString();
    orderDateController.text = order.orderDate;
    totalPriceController.text = order.totalPrice.toString();
    selectedStatus = order.status;

    _showOrderDialog(order: order);
  }

  // Add new order
  void _addOrder() {
    customerIdController.clear();
    orderDateController.clear();
    totalPriceController.clear();
    selectedStatus = null;

    _showOrderDialog();
  }

  // Show dialog for adding/editing order
  void _showOrderDialog({Order? order}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(order == null ? 'Thêm đơn hàng mới' : 'Chỉnh sửa đơn hàng'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: customerIdController,
                    decoration: const InputDecoration(labelText: 'ID khách hàng'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập ID khách hàng';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: orderDateController,
                    decoration: const InputDecoration(labelText: 'Ngày đặt'),
                    readOnly: true,
                    onTap: () => _selectDate(context, orderDateController),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng chọn ngày đặt';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: totalPriceController,
                    decoration: const InputDecoration(labelText: 'Tổng giá'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tổng giá';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedStatus,
                    onChanged: (newValue) {
                      setState(() {
                        selectedStatus = newValue;
                      });
                    },
                    items: statuses
                        .map((status) => DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    ))
                        .toList(),
                    decoration: const InputDecoration(labelText: 'Trạng thái'),
                    validator: (value) {
                      if (value == null) {
                        return 'Vui lòng chọn trạng thái';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final orderData = Order(
                    orderId: 0,
                    customerId: int.parse(customerIdController.text),
                    orderDate: orderDateController.text,
                    totalPrice: double.parse(totalPriceController.text),
                    status: selectedStatus!,
                  );
                  try {
                    if (order == null) {
                      await _orderService.addOrder(orderData);
                      setState(() {
                        orders.add(orderData);
                      });
                    } else {
                      await _orderService.updateOrder(orderData);
                      final index = orders.indexOf(order);
                      setState(() {
                        orders[index] = orderData;
                      });
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(order == null ? 'Thêm đơn hàng thành công' : 'Cập nhật đơn hàng thành công')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Lỗi: $e')),
                    );
                  }
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  // Delete order
  void _deleteOrder(Order order) async {
    try {
      await _orderService.deleteOrder(order.orderId);
      setState(() {
        orders.remove(order);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Xóa đơn hàng thành công')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $e')),
      );
    }
  }

  // Date picker
  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        controller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý đơn hàng'),
        actions: [
          IconButton(
            onPressed: () => _addOrder(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
        itemCount: orders.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final order = orders[index];
          return ListTile(
            title: Text('Đơn hàng ${order.orderId}'),
            subtitle: Text('Ngày đặt: ${order.orderDate} - Tổng giá: ${order.totalPrice}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editOrder(order),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteOrder(order),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
