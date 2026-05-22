class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void info() {
    print("Tôi là một con người. Tên: $name, Tuổi: $age");
  }
}

class Employee extends Person {
  String employeeId;
  double salary;

  Employee(String name, int age, this.employeeId, this.salary) : super(name, age);

  @override
  void info() {
    print("=== Thông Tin Nhân Viên ===");
    print("Mã nhân viên: $employeeId");
    print("Tên nhân viên: $name");
    print("Tuổi: $age");
    print("Mức lương: $salary VND");
  }
}

void main() {
  Employee emp = Employee("Phan Văn Khải", 28, "EMP888", 18500000);

  emp.info();
}