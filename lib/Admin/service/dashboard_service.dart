import 'dart:convert';
import 'package:http/http.dart' as http;

class DashboardService {
  Future<Map<String, dynamic>> fetchDashboardData() async {
    final response = await http.get(Uri.parse('http://localhost:8080/api/dashboard'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load dashboard data');
    }
  }
}
