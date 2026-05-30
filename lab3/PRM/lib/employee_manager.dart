import 'package:prm/sales_employee.dart';

import 'employee.dart';
import 'manager.dart';

class EmployeeManager {
  final List<Employee> _list = [];
  List<Employee> get list => _list;

  void addEmployee(Employee emp) {
    _list.add(emp);
    print("Add employee ${emp.fullName} successfull");
  }

  void displayAll() {
    if(_list.isEmpty) {
      print("List is empty.");
      return;
    }
    for (var emp in _list) {
      print(emp);
    }
  }

  Employee? findById(String id) {
    for (var emp in _list) {
      if(emp.id == id) {
        return emp;
      }
    }
    return null;
  }

  bool deleteById(String id) {
    final emp = findById(id);
    if (emp != null) {
      _list.remove(emp);
      return true;
    }
    return false;
  }

  Employee? findByIncomeRange(double min, double max) {
    bool found = false;
    for(var emp in _list) {
      if(emp.getIncome() >= min && emp.getIncome() <= max) {
        print(emp);
        found = true;
      }
    }
    if(!found) print("Dont found emp in this range!");
  }

  void sortByName() {
    _list.sort((a, b) => a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase()));
  }

  void sortByTotalIncome() {
    _list.sort((a, b) => a.getIncome().compareTo(b.getIncome()));
  }

  void displayTop5() {
    if(_list.isEmpty) {
      print("List is empty");
      return;
    }

    sortByTotalIncome();

    var top = _list.take(5).toList();
    for (var emp in top) {
      print(emp);
    }
  }

  bool updateEmployee({
    required String id,
    String? newName,
    double? newBaseSalary,
    double? newSalesRevenue,
    double? newCommissionRate,
    double? newResponsibilityAllowance,
  }) {
    Employee? emp = findById(id);
    if (emp == null) return false;

    if (newName != null && newName.isNotEmpty) emp.fullName = newName;
    if (newBaseSalary != null) emp.baseSalary = newBaseSalary;

    if (emp is SalesEmployee) {
      if (newSalesRevenue != null) emp.salesRevenue = newSalesRevenue;
      if (newCommissionRate != null) emp.commissionRate = newCommissionRate;
    }

    else if (emp is Manager) {
      if (newResponsibilityAllowance != null) {
        emp.responsibilityAllowance = newResponsibilityAllowance;
      }
    }

    return true;
  }
}