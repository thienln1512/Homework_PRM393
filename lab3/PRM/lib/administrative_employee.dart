import 'employee.dart';

class AdministrativeEmployee extends Employee {
  AdministrativeEmployee(super.id, super.fullname, super.baseSalary);

  @override
  double getIncome() {
    return baseSalary;
  }
}