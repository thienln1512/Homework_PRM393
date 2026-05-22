void main() {
  Set<String> courses = {"Dart", "Flutter", "Android"};

  print("Set ban đầu: $courses");

  courses.add("iOS");

  courses.add("Dart");
  courses.add("Flutter");

  print("Set sau khi cố tình thêm trùng lặp: $courses");
  print("Lưu ý: Các phần tử trùng lặp ('Dart', 'Flutter') tự động bị loại bỏ!");
}