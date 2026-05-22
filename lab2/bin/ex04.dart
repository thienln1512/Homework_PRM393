void main() {
  double score = 75.5;
  String rank = "";

  if (score < 50) {
    rank = "Fail";
  } else if (score >= 50 && score <= 65) {
    rank = "Average";
  } else if (score >= 66 && score <= 80) {
    rank = "Good";
  } else if (score >= 81 && score <= 100) {
    rank = "Excellent";
  } else {
    rank = "Invalid Score (Điểm không hợp lệ)";
  }

  print("Điểm số: $score => Học lực: $rank");
}