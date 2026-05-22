Future<List<int>> loadData() {
  return Future.delayed(Duration(seconds: 2), () {
    return [10, 20, 30, 40, 50];
  });
}

void main() async {
  List<int> result = await loadData();

  print("Kết quả dữ liệu nhận được: $result");
}