void register({required String name, int age = 18}) {
  print("Đăng ký thành công: Tài khoản: $name | Tuổi: $age");
}

void main() {
  print("=== Hệ Thống Đăng Ký ===");

  register(name: "Lê Văn C");

  register(name: "Trần Thị B", age: 22);

  register(age: 25, name: "Hoàng Văn D");
}