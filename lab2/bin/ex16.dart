class Product {
  String id;
  String name;
  double price;

  Product(this.id, this.name, this.price);
}

class Cart {
  List<Product> items = [];

  void addProduct(Product product) {
    items.add(product);
    print("Đã thêm [${product.name}] vào giỏ hàng.");
  }

  void removeProduct(String productId) {
    items.removeWhere((item) => item.id == productId);
    print("Đã xóa sản phẩm có mã ID: $productId khỏi giỏ hàng.");
  }

  double calculateTotal() {
    double sum = 0;
    for (var item in items) {
      sum += item.price;
    }
    return sum;
  }

  Future<void> checkout() async {
    print("\n[Hệ thống] Đang kết nối đến cổng thanh toán...");
    await Future.delayed(Duration(seconds: 3));

    print("THANH TOÁN THÀNH CÔNG!");
    print("Cart Total: ${calculateTotal()} VND");
  }
}

void main() async {
  print("=== KHỞI TẠO HỆ THỐNG GIỎ HÀNG ===");
  Cart myCart = Cart();

  Product p1 = Product("SP01", "Chuột Máy Tính Logitech", 250000);
  Product p2 = Product("SP02", "Bàn Phím Cơ AKKO", 1000000);
  Product p3 = Product("SP03", "Lót Chuột RGB", 150000);

  myCart.addProduct(p1);
  myCart.addProduct(p2);
  myCart.addProduct(p3);

  myCart.removeProduct("SP03");

  await myCart.checkout();
}