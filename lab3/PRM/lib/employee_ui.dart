import 'dart:io';
import 'employee_manager.dart';
import 'employee.dart';
import 'administrative_employee.dart';
import 'sales_employee.dart';
import 'manager.dart';

class EmployeeUI {
  final EmployeeManager _manager;

  EmployeeUI(this._manager);

  // =========================================================================
  // UI: Input and Add New Employee
  // =========================================================================
  void inputEmployeeMenu() {
    while (true) {
      print("\n--- SELECT EMPLOYEE TYPE TO ADD ---");
      print("1. Administrative Employee");
      print("2. Sales Employee");
      print("3. Manager");
      print("0. Back to main menu");
      stdout.write("Your choice: ");
      String? type = stdin.readLineSync();

      if (type == '0') break;
      if (type != '1' && type != '2' && type != '3') {
        print("Invalid choice! Please try again.");
        continue;
      }

      stdout.write("Enter Employee ID: ");
      String id = stdin.readLineSync() ?? "";

      if (_manager.findById(id) != null) {
        print("Error: This Employee ID already exists in the system!");
        continue;
      }

      stdout.write("Enter Full Name: ");
      String fullName = stdin.readLineSync() ?? "";

      stdout.write("Enter Base Salary: ");
      double baseSalary = double.tryParse(stdin.readLineSync() ?? "") ?? 0.0;

      if (type == '1') {
        _manager.addEmployee(AdministrativeEmployee(id, fullName, baseSalary));
      }
      else if (type == '2') {
        stdout.write("Enter Sales Revenue: ");
        double salesRevenue = double.tryParse(stdin.readLineSync() ?? "") ?? 0.0;
        stdout.write("Enter Commission Rate (e.g., 0.1 for 10%): ");
        double commissionRate = double.tryParse(stdin.readLineSync() ?? "") ?? 0.0;

        _manager.addEmployee(SalesEmployee(id, fullName, baseSalary, salesRevenue, commissionRate));
      }
      else if (type == '3') {
        stdout.write("Enter Responsibility Allowance: ");
        double responsibilityAllowance = double.tryParse(stdin.readLineSync() ?? "") ?? 0.0;

        _manager.addEmployee(Manager(id, fullName, baseSalary, responsibilityAllowance));
      }
    }
  }

  // =========================================================================
  // UI: Search Employee by ID
  // =========================================================================
  void searchEmployeeById() {
    stdout.write("Enter Employee ID to search: ");
    String id = stdin.readLineSync() ?? "";
    Employee? emp = _manager.findById(id);
    if (emp != null) {
      print("\n--- SEARCH RESULT ---");
      print(emp); // ĐÃ SỬA: Bọc trong print để hiển thị dữ liệu
    } else {
      print("No employee found with ID: $id");
    }
  }

  // =========================================================================
  // UI: Delete Employee by ID
  // =========================================================================
  void deleteEmployeeById() {
    stdout.write("Enter Employee ID to delete: ");
    String id = stdin.readLineSync() ?? "";
    bool success = _manager.deleteById(id);
    if (success) {
      print("Successfully deleted employee with ID: $id.");
    } else {
      print("Deletion failed! Employee ID not found: $id");
    }
  }

  // =========================================================================
  // UI: Search Employees by Income Range
  // =========================================================================
  void searchByIncomeRangeMenu() {
    stdout.write("Enter Minimum Income (Min): ");
    double min = double.tryParse(stdin.readLineSync() ?? "") ?? 0.0;
    stdout.write("Enter Maximum Income (Max): ");
    double max = double.tryParse(stdin.readLineSync() ?? "") ?? 0.0;

    _manager.findByIncomeRange(min, max);
  }

  // =========================================================================
  // UI: Update Employee Information by ID
  // =========================================================================
  void updateEmployeeMenu() {
    stdout.write("Enter Employee ID to update: ");
    String id = stdin.readLineSync() ?? "";

    Employee? emp = _manager.findById(id);
    if (emp == null) {
      print("Employee ID not found: $id");
      return;
    }

    print("\n--- UPDATING EMPLOYEE: ${emp.fullName} ---");

    stdout.write("Enter new name (leave blank to keep current): ");
    String nameInput = stdin.readLineSync() ?? "";
    String? newName = nameInput.isNotEmpty ? nameInput : null;

    stdout.write("Enter new base salary (leave blank to keep current): ");
    String salaryInput = stdin.readLineSync() ?? "";
    double? newBaseSalary = salaryInput.isNotEmpty ? double.tryParse(salaryInput) : null;

    double? newSalesRevenue;
    double? newCommissionRate;
    double? newResponsibilityAllowance;

    if (emp is SalesEmployee) {
      print("[Sales Employee]");
      stdout.write("Enter new sales revenue (leave blank to keep current): ");
      String revenueInput = stdin.readLineSync() ?? "";
      newSalesRevenue = revenueInput.isNotEmpty ? double.tryParse(revenueInput) : null;

      stdout.write("Enter new commission rate (leave blank to keep current): ");
      String rateInput = stdin.readLineSync() ?? "";
      newCommissionRate = rateInput.isNotEmpty ? double.tryParse(rateInput) : null;
    }
    else if (emp is Manager) {
      print("[Manager]");
      stdout.write("Enter new responsibility allowance (leave blank to keep current): ");
      String allowanceInput = stdin.readLineSync() ?? "";
      newResponsibilityAllowance = allowanceInput.isNotEmpty ? double.tryParse(allowanceInput) : null;
    }

    bool isSuccess = _manager.updateEmployee(
      id: id,
      newName: newName,
      newBaseSalary: newBaseSalary,
      newSalesRevenue: newSalesRevenue,
      newCommissionRate: newCommissionRate,
      newResponsibilityAllowance: newResponsibilityAllowance,
    );

    if (isSuccess) {
      print("=> Employee information updated successfully!");
    } else {
      print("=> Update failed!");
    }
  }
}