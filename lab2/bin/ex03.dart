void main() {
  print("=== Phân Biệt Biến Và Hằng Số ===");

  var name = "Dart";
  name = "Flutter";
  print("var name: $name");

  dynamic flexibleVar = "Xin chào";
  print("dynamic lúc đầu: $flexibleVar");
  flexibleVar = 100;
  print("dynamic lúc sau: $flexibleVar");

  final DateTime currentRuntime = DateTime.now();
  print("final (Runtime): $currentRuntime");

  const double pi = 3.14159;
  print("const (Compile-time): $pi");
}