import 'dart:async';

Stream<int> countStream() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

void main() {
  print("Bắt đầu lắng nghe dòng Stream:");

  late StreamSubscription<int> subscription;

  subscription = countStream().listen(
          (data) {
        print("Nhận giá trị: $data (tại thời điểm: ${DateTime.now().second}s)");
      },
      onDone: () {
        print("Dòng dữ liệu Stream đã phát xong!");
        subscription.cancel();
        print("Đã hủy Subscription an toàn.");
      }
  );
}