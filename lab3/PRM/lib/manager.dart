import 'employee.dart';

class Manager extends Employee {
  double responsibilityAllowance;

  Manager(super.id, super.fullname, super.baseSalary, this.responsibilityAllowance);

  @override
  double getIncome() {
    return baseSalary + responsibilityAllowance;
  }
}