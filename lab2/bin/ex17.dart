import 'dart:async';

class Question {
  String questionText;
  List<String> options;
  String correctAnswer;

  Question(this.questionText, this.options, this.correctAnswer);
}

void main() {
  List<Question> quizList = [
    Question(
        "Ngôn ngữ lập trình chính dùng để viết ứng dụng Flutter là gì?",
        ["A. Java", "B. Dart", "C. Swift", "D. Python"],
        "B"
    ),
    Question(
        "Từ khóa nào dùng để khai báo hằng số tại thời điểm compile-time trong Dart?",
        ["A. var", "B. final", "C. const", "D. dynamic"],
        "C"
    ),
    Question(
        "Kiểu dữ liệu nào trong bộ sưu tập (Collections) của Dart KHÔNG chấp nhận giá trị trùng lặp?",
        ["A. List", "B. Map", "C. Set", "D. Array"],
        "C"
    )
  ];

  print("=== HỆ THỐNG THI TRẮC NGHIỆM TỰ ĐỘNG ===");
  print("Các câu hỏi sẽ tự động xuất hiện sau mỗi 3 giây...\n");

  Stream<Question> getQuizStream() async* {
    for (var question in quizList) {
      await Future.delayed(Duration(seconds: 3));
      yield question;
    }
  }

  int count = 1;
  late StreamSubscription<Question> quizSubscription;

  quizSubscription = getQuizStream().listen(
          (question) {
        print("Câu hỏi số $count: ${question.questionText}");

        for (var option in question.options) {
          print("  $option");
        }

        switch (question.correctAnswer) {
          case "A":
            print(">> Gợi ý hệ thống: Đáp án đúng nằm ở mục đầu tiên.");
            break;
          case "B":
            print(">> Gợi ý hệ thống: Đáp án chính xác là B.");
            break;
          case "C":
            print(">> Gợi ý hệ thống: Đáp án chính xác là C.");
            break;
          default:
            print(">> Không có gợi ý.");
        }
        count++;
      },
      onDone: () {
        print("ĐÃ HIỂN THỊ HẾT TẤT CẢ CÂU HỎI TRẮC NGHIỆM!");
        quizSubscription.cancel();
      }
  );
}