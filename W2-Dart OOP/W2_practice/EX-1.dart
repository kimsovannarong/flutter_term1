enum Skill { 
  FLUTTER,
  DART,
  OTHER 
  }
// class address
class Address {
  final String street;
  final String city;
  final String zipCode;

  Address(this.street, this.city, this.zipCode);
}
//class employee
class Employee {
  final String _name;
  final double _baseSalary;
  final List<Skill> _skills;
  final Address _address;
  final int _yearOfExperience;

  // Main constructor
  Employee(this._name, this._baseSalary, this._skills, this._address, this._yearOfExperience);
  // named constuctor
  Employee.moblieDeveloper(this._name, this._baseSalary,this._address,this._yearOfExperience)
      : _skills = [Skill.FLUTTER, Skill.DART];
  
    void printDetails() {
    print('Employee: $_name,\n Base Salary: \$${_baseSalary},\n Skills: ${ _skills.map((s) => s.toString().split('.').last).join(', ')}');
  }

  
  // get method 
  String get name{
    return _name;
  }
  double get baseslary{
    return _baseSalary;
  }
  int get year{
    return _yearOfExperience;
  }
  List<Skill> get skill{
    return _skills;
  }
  Address get address{
    return _address;
  }
  // calculation method 
  double Computesalary(){
    double total=_baseSalary + (2000 * _yearOfExperience);
    for (var skill in _skills){
      switch(skill){
        case Skill.DART: 
          total+=3000;
          break;
        case Skill.FLUTTER:
          total+=5000;
          break;
        case Skill.OTHER:
          total+=1000;
          break;
      }
    }
    return total;
  }
}
void main(){
  Address address = Address("524 st", "Phnom Penh", "+855");
  Employee emp1= Employee.moblieDeveloper("Narong", 40000,address, 2);
  emp1.printDetails();
  print("Total of salary is ${emp1.Computesalary()}");
}