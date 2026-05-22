class Student {
  String name;
  int age;
  double gpa;

  Student(this.name, this.age, this.gpa);

  @override
  String toString() {
    return 'Student(Tên: $name, Tuổi: $age, GPA: $gpa)';
  }
}

void main() {
  Student s1 = Student("Nguyễn Văn A", 20, 3.2);
  Student s2 = Student("Lê Thị B", 21, 3.8);
  Student s3 = Student("Trần Văn C", 19, 2.5);
  Student s4 = Student("Phạm Minh D", 22, 3.9);
  Student s5 = Student("Hoàng Thu E", 20, 3.4);

  List<Student> studentList = [s1, s2, s3, s4, s5];

  print("=== Danh Sách Sinh Viên ===");
  for (var student in studentList) {
    print(student);
  }
}