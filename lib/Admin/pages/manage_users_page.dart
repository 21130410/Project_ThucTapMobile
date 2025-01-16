import 'package:flutter/material.dart';
import '../service/user_service.dart';

class User {
  int userId;
  String userName;
  String password;
  String role;
  String address;
  String email;
  String name;
  String phone;



  User({
    required this.userId,
    required this.userName,
    required this.password,
    required this.role,
    required this.address,
    required this.email,
    required this.name,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      userName: json['username'],
      password: json['password'],
      role: json['role'],
      address: json['address'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': userName,
      'password': password,
      'role': role,
      'address': address,
      'email': email,
      'name': name,
      'phone': phone,
    };
  }
  Map<String, dynamic> toJsonForCreate() {
    return {
      'username': userName,
      'password': password,
      'name': name,
      'email': email,
      'role': role,
      'phone': phone,
      'address': address,
    };
  }

}


class ManageUsersPage extends StatefulWidget {
  const ManageUsersPage({Key? key}) : super(key: key);

  @override
  State<ManageUsersPage> createState() => _ManageUsersPageState();
}

class _ManageUsersPageState extends State<ManageUsersPage> {
  final UserService _userService = UserService();
  List<User> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final data = await _userService.getAllUsers();
      setState(() {
        users = data;
      });
    } catch (e) {
      print("Error fetching users: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }



  void _editUser({User? user}) {
    final TextEditingController userIdController = TextEditingController(
        text: user != null ? user.userId.toString() : '');
    final TextEditingController userNameController = TextEditingController(
        text: user != null ? user.userName : '');
    final TextEditingController passwordController = TextEditingController(
        text: user != null ? user.password : '');
    final TextEditingController nameController = TextEditingController(
        text: user != null ? user.name : '');
    final TextEditingController emailController = TextEditingController(
        text: user != null ? user.email : '');
    final TextEditingController roleController = TextEditingController(
        text: user != null ? user.role : '');
    final TextEditingController phoneController = TextEditingController(
        text: user != null ? user.phone : '');
    final TextEditingController addressController = TextEditingController(
        text: user != null ? user.address : '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Chỉnh sửa người dùng'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: userIdController,
                  decoration: const InputDecoration(labelText: 'ID Người dùng'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: userNameController,
                  decoration: const InputDecoration(labelText: 'Tên người dùng'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Mật khẩu'),
                  obscureText: true,
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Tên'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: roleController,
                  decoration: const InputDecoration(labelText: 'Role'),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Số điện thoại'),
                  keyboardType: TextInputType.phone,
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Địa chỉ'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () async {
                final updatedUser = User(
                  userId: int.parse(userIdController.text),
                  userName: userNameController.text,
                  password: passwordController.text,
                  name: nameController.text,
                  email: emailController.text,
                  role: roleController.text,
                  phone: phoneController.text,
                  address: addressController.text,
                );

                try {
                    await _userService.updateUser(updatedUser);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Chỉnh sửa người dùng thành công')),
                    );
                  _fetchUsers();
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Lỗi khi chỉnh người dùng: $e\n Vui lòng kiểm tra lại thông tin.')),
                  );
                }
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }


  void _addUser({User? user}) {
    final TextEditingController userNameController = TextEditingController(
        text: user != null ? user.userName : '');
    final TextEditingController passwordController = TextEditingController(
        text: user != null ? user.password : '');
    final TextEditingController nameController = TextEditingController(
        text: user != null ? user.name : '');
    final TextEditingController emailController = TextEditingController(
        text: user != null ? user.email : '');
    final TextEditingController roleController = TextEditingController(
        text: user != null ? user.role : '');
    final TextEditingController phoneController = TextEditingController(
        text: user != null ? user.phone : '');
    final TextEditingController addressController = TextEditingController(
        text: user != null ? user.address : '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Thêm người dùng mới'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: userNameController,
                  decoration: const InputDecoration(labelText: 'Tên người dùng'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Mật khẩu'),
                  obscureText: true,
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Tên'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: roleController,
                  decoration: const InputDecoration(labelText: 'Role'),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Số điện thoại'),
                  keyboardType: TextInputType.phone,
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Địa chỉ'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () async {
                final createUser = User(
                  userId: 0,
                  userName: userNameController.text,
                  password: passwordController.text,
                  name: nameController.text,
                  email: emailController.text,
                  role: roleController.text,
                  phone: phoneController.text,
                  address: addressController.text,
                );

                try {
                  await _userService.createUser(createUser);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Thêm người dùng thành công')),
                  );
                  _fetchUsers();
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Lỗi khi thêm người dùng: $e\n Vui lòng kiểm tra lại thông tin.')),
                  );
                }
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  void _deleteUser(User user) async {
    try {
      await _userService.deleteUser(user.userId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Xóa người dùng thành công')),
      );
      _fetchUsers();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi xóa người dùng: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý người dùng'),
        actions: [
          IconButton(
            onPressed: () => _addUser(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(user.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: ${user.email}'),
                  Text('Số điện thoại: ${user.phone}'),
                  Text('Địa chỉ: ${user.address}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _editUser(user: user),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteUser(user),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
