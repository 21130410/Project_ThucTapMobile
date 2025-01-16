import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    int totalOrders = 120;
    int totalProductsSold = 350;
    int totalUsers = 200;
    double totalRevenue = 1500000;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Thống kê tổng quan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildStatisticCard(
                  icon: Icons.shopping_cart,
                  title: 'Số đơn hàng',
                  value: totalOrders.toString(),
                  color: Colors.blue,
                ),
                _buildStatisticCard(
                  icon: Icons.shopping_bag,
                  title: 'Sản phẩm đã bán',
                  value: totalProductsSold.toString(),
                  color: Colors.green,
                ),
                _buildStatisticCard(
                  icon: Icons.people,
                  title: 'Người dùng',
                  value: totalUsers.toString(),
                  color: Colors.orange,
                ),
                _buildStatisticCard(
                  icon: Icons.attach_money,
                  title: 'Doanh thu (VNĐ)',
                  value: totalRevenue.toStringAsFixed(0),
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
