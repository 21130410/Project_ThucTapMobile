import 'package:ban_mobile/Admin/pages/dashboard_page.dart';
import 'package:ban_mobile/Admin/pages/manage_orders_page.dart';
import 'package:ban_mobile/Admin/pages/manage_products_page.dart';
import 'package:ban_mobile/Admin/pages/manage_users_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const ManageProductsPage(),
    const ManageUsersPage(),
    const ManageOrdersPage(),
  ];

  final List<String> _titles = [
    'Thống kê tổng quan',
    'Quản lý Sản phẩm',
    'Quản lý Người dùng',
    'Quản lý Đơn hàng',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
      ),
      body: _pages[_selectedIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightGreen,
              ),
              child: Text(
                'Admin Panel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Thống kê tổng quan'),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Quản lý Sản phẩm'),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Quản lý Người dùng'),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt),
              title: const Text('Quản lý Đơn hàng'),
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
