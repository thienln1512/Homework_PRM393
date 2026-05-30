abstract class Employee {
  String _id;
  String _fullName;
  double _baseSalary;

  Employee(this._id, this._fullName, this._baseSalary);

  double get baseSalary => _baseSalary;

  set baseSalary(double value) {
    _baseSalary = value;
  }

  String get fullName => _fullName;

  set fullName(String value) {
    _fullName = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
  double getIncome();
  double getTax() {
    double income = getIncome();
    if ( income < 9000000) {
      return 0.0;
    } else if( income <= 15000000) {
      return income * 0.10;
    } else {
      return income * 0.12;
    }
  }

  @override
  String toString() {
    return 'Employee{ID: $_id | Fullname: $_fullName | BaseSalary: $_baseSalary | Income: ${getIncome()} | Tax: ${getTax()}}';
  }
}