import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../service/product_service.dart';

class Product {
  int productId;
  int brandId;
  String productName;
  String releaseDate;
  String specifications;
  double price;
  int stockQuantity;
  String? image;

  Product({
    required this.productId,
    required this.brandId,
    required this.productName,
    required this.releaseDate,
    required this.specifications,
    required this.price,
    required this.stockQuantity,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      brandId: json['brandId'],
      productName: json['productName'],
      releaseDate: json['releaseDate'],
      specifications: json['specifications'],
      price: json['price'],
      stockQuantity: json['stockQuantity'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'brandId': brandId,
      'productName': productName,
      'releaseDate': releaseDate,
      'specifications': specifications,
      'price': price,
      'stockQuantity': stockQuantity,
      'image': image,
    };
  }

  Map<String, dynamic> toJsonForCreate() {
    return {
      'brandId': brandId,
      'productName': productName,
      'releaseDate': releaseDate,
      'specifications': specifications,
      'price': price,
      'stockQuantity': stockQuantity,
      'image': image,
    };
  }
}

class ManageProductsPage extends StatefulWidget {
  const ManageProductsPage({Key? key}) : super(key: key);

  @override
  State<ManageProductsPage> createState() => _ManageProductsPageState();
}

class _ManageProductsPageState extends State<ManageProductsPage> {
  final ProductService _productService = ProductService();
  List<Product> products = [];
  bool isLoading = true;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final data = await _productService.getAllProducts();
      setState(() {
        products = data;
      });
    } catch (e) {
      print("Lỗi khi lấy sản phẩm: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _editProduct({Product? product}) {
    final TextEditingController productIdController = TextEditingController(
        text: product != null ? product.productId.toString() : '');
    final TextEditingController brandIdController = TextEditingController(
        text: product != null ? product.brandId.toString() : '');
    final TextEditingController productNameController = TextEditingController(
        text: product != null ? product.productName : '');
    final TextEditingController releaseDateController = TextEditingController(
        text: product != null ? product.releaseDate : '');
    final TextEditingController specificationsController = TextEditingController(
        text: product != null ? product.specifications : '');
    final TextEditingController priceController = TextEditingController(
        text: product != null ? product.price.toString() : '');
    final TextEditingController stockQuantityController = TextEditingController(
        text: product != null ? product.stockQuantity.toString() : '');
    String? selectedImagePath = product?.image;

    void _pickImage() async {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          selectedImagePath = pickedFile.path;
        });
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text( 'Chỉnh sửa sản phẩm'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: productIdController,
                  decoration: const InputDecoration(labelText: 'ID sản phẩm'),
                ),
                TextField(
                  controller: brandIdController,
                  decoration: const InputDecoration(labelText: 'ID thương hiệu'),
                ),
                TextField(
                  controller: productNameController,
                  decoration: const InputDecoration(labelText: 'Tên sản phẩm'),
                ),
                TextField(
                  controller: releaseDateController,
                  decoration: const InputDecoration(labelText: 'Ngày phát hành'),
                ),
                TextField(
                  controller: specificationsController,
                  decoration: const InputDecoration(labelText: 'Thông số kỹ thuật'),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Giá'),
                ),
                TextField(
                  controller: stockQuantityController,
                  decoration: const InputDecoration(labelText: 'Số lượng trong kho'),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: selectedImagePath != null
                        ? Image.file(File(selectedImagePath!), fit: BoxFit.cover)
                        : const Icon(Icons.image, size: 50),
                  ),
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
                  final productData = Product(
                    productId: int.parse(productIdController.text),
                    brandId: int.parse(brandIdController.text),
                    productName: productNameController.text,
                    releaseDate: releaseDateController.text,
                    specifications: specificationsController.text,
                    price: double.parse(priceController.text),
                    stockQuantity: int.parse(stockQuantityController.text),
                    image: selectedImagePath,
                  );
                  try {
                    await _productService.updateProduct(productData);
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Cập nhật sản phẩm thành công')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Lỗi: $e')),
                  );
                }
                Navigator.of(context).pop();
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  void _addProduct({Product? product}) {
    final TextEditingController brandIdController = TextEditingController(
        text: product != null ? product.brandId.toString() : '');
    final TextEditingController productNameController = TextEditingController(
        text: product != null ? product.productName : '');
    final TextEditingController releaseDateController = TextEditingController(
        text: product != null ? product.releaseDate : '');
    final TextEditingController specificationsController = TextEditingController(
        text: product != null ? product.specifications : '');
    final TextEditingController priceController = TextEditingController(
        text: product != null ? product.price.toString() : '');
    final TextEditingController stockQuantityController = TextEditingController(
        text: product != null ? product.stockQuantity.toString() : '');
    String? selectedImagePath = product?.image;

    void _pickImage() async {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          selectedImagePath = pickedFile.path;
        });
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Thêm sản phẩm mới'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: brandIdController,
                  decoration: const InputDecoration(labelText: 'ID thương hiệu'),
                ),
                TextField(
                  controller: productNameController,
                  decoration: const InputDecoration(labelText: 'Tên sản phẩm'),
                ),
                TextField(
                  controller: releaseDateController,
                  decoration: const InputDecoration(labelText: 'Ngày phát hành'),
                ),
                TextField(
                  controller: specificationsController,
                  decoration: const InputDecoration(labelText: 'Thông số kỹ thuật'),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Giá'),
                ),
                TextField(
                  controller: stockQuantityController,
                  decoration: const InputDecoration(labelText: 'Số lượng trong kho'),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: selectedImagePath != null
                        ? Image.file(File(selectedImagePath!), fit: BoxFit.cover)
                        : const Icon(Icons.image, size: 50),
                  ),
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
                try {
                  final productData = Product(
                    productId: 0,
                    brandId: int.parse(brandIdController.text),
                    productName: productNameController.text,
                    releaseDate: releaseDateController.text,
                    specifications: specificationsController.text,
                    price: double.parse(priceController.text),
                    stockQuantity: int.parse(stockQuantityController.text),
                    image: selectedImagePath,
                  );

                    await _productService.addProduct(productData);
                    setState(() {
                      products.add(productData);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Thêm sản phẩm thành công')),
                    );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Lỗi: $e')),
                  );
                }
                Navigator.of(context).pop();
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  void _deleteProduct(Product product) async {
    try {
      await _productService.deleteProduct(product.productId);
      setState(() {
        products.remove(product);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Xóa sản phẩm thành công')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý sản phẩm'),
        actions: [
          IconButton(
            onPressed: () => _addProduct(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: product.image != null
                  ? Image.file(File(product.image!), width: 50, fit: BoxFit.cover)
                  : const Icon(Icons.image),
              title: Text(product.productName),
              subtitle: Text('Giá: ${product.price.toString()}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _editProduct(product: product),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                      onPressed: () => _deleteProduct(product),
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
