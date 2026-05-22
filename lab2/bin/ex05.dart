void main() {
  String day = "Mon";

  switch (day) {
    case "Mon":
      print("Thứ Hai: Học lý thuyết Dart cơ bản.");
      break;
    case "Tue":
      print("Thứ Ba: Thực hành viết hàm và hướng đối tượng.");
      break;
    case "Wed":
      print("Thứ Tư: Làm việc với List, Set, Map.");
      break;
    case "Thu":
      print("Thứ Năm: Học lập trình bất đồng bộ.");
      break;
    case "Fri":
      print("Thứ Sáu: Làm mini project.");
      break;
    case "Sat":
    case "Sun":
      print("Cuối tuần: Nghỉ ngơi và đi chơi thôi!");
      break;
    default:
      print("Ký hiệu ngày không hợp lệ! Vui lòng dùng: Mon, Tue, Wed, Thu, Fri, Sat, Sun.");
  }
}