double calcSalary(double hours, double rate) => hours * rate;

void main() {
  double workingHours = 44.5;
  double hourlyRate = 150000;

  double totalSalary = calcSalary(workingHours, hourlyRate);

  print("=== Tính Lương ===");
  print("Số giờ làm: $workingHours giờ");
  print("Lương theo giờ: $hourlyRate VND");
  print("Tổng lương nhận được: $totalSalary VND");
}