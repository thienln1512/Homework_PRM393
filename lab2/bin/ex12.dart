class Product {
  String id;
  String name;
  double price;
  int quantity;

  Product({required this.id, required this.name, required this.price, required this.quantity});

  double total() {
    return price * quantity;
  }
}

void main() {
  Product prod = Product(id: "P001", name: "Điện thoại iPhone 15", price: 25000000, quantity: 3);

  print("=== Chi Tiết Sản Phẩm ===");
  print("Mã SP: ${prod.id}");
  print("Tên SP: ${prod.name}");
  print("Đơn giá: ${prod.price} VND");
  print("Số lượng: ${prod.quantity}");
  print("--------------------------");
  print("Tổng thành tiền: ${prod.total()} VND");
}