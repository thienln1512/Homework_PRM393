import 'employee.dart';

class SalesEmployee extends Employee {
  double salesRevenue;
  double commissionRate;

  SalesEmployee(super.id, super.fullname, super.baseSalary, this.commissionRate, this.salesRevenue);

  @override
  double getIncome() {
    return baseSalary + (commissionRate * salesRevenue);
  }
}