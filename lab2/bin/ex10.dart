void main() {
  Map<String, int> studentScores = {
    "An": 85,
    "Bình": 92,
    "Cường": 78,
    "Dũng": 95,
    "Em": 89
  };

  print("Danh sách điểm: $studentScores");

  String highestStudent = "";
  int highestScore = -1;

  studentScores.forEach((name, score) {
    if (score > highestScore) {
      highestScore = score;
      highestStudent = name;
    }
  });

  print("Học sinh: $highestStudent với số điểm cao nhất là: $highestScore");
}