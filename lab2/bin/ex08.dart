void main() {
  List<int> numbers = [12, 5, 8, 23, 42, 17, 90, 31, 14, 7];

  print("Danh sách gốc: $numbers");

  List<int> evenNumbers = [];
  List<int> oddNumbers = [];

  for (int number in numbers) {
    if (number % 2 == 0) {
      evenNumbers.add(number);
    } else {
      oddNumbers.add(number);
    }
  }

  print("Các số chẵn: $evenNumbers");
  print("Các số lẻ: $oddNumbers");
}