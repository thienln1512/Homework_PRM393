import 'dart:io';
import 'package:prm/employee_manager.dart';
import 'package:prm/employee_ui.dart';

void main() {
  // 1. Initialize the Data Logic layer (Manager)
  EmployeeManager manager = EmployeeManager();

  // 2. Initialize the User Interface layer (UI) and pass the manager
  EmployeeUI ui = EmployeeUI(manager);

  while (true) {
    print("\n================ EMPLOYEE MANAGEMENT PROGRAM ================");
    print("1. Input employee list");
    print("2. Display all employees");
    print("3. Search employee by ID");
    print("4. Delete employee by ID");
    print("5. Update employee information");
    print("6. Search employees by income range");
    print("7. Sort employees by name (A-Z)");
    print("8. Sort employees by income (Descending)");
    print("9. Display TOP 5 highest income employees");
    print("0. Exit program");
    print("================================================================");
    stdout.write("Please select a function (0-9): ");

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        ui.inputEmployeeMenu();
        break;
      case '2':
        manager.displayAll();
        break;
      case '3':
        ui.searchEmployeeById();
        break;
      case '4':
        ui.deleteEmployeeById();
        break;
      case '5':
        ui.updateEmployeeMenu();
        break;
      case '6':
        ui.searchByIncomeRangeMenu();
        break;
      case '7':
        manager.sortByName();
        print("Employees sorted by name (A-Z).");
        manager.displayAll();
        break;
      case '8':
        manager.sortByTotalIncome();
        print("Employees sorted by income descending.");
        manager.displayAll();
        break;
      case '9':
        manager.displayTop5();
        break;
      case '0':
        print("Goodbye! See you again.");
        return;
      default:
        print("Invalid choice! Please select between 0 and 9.");
    }
  }
}