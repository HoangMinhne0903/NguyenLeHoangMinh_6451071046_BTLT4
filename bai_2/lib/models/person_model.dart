class PersonModel {
  final String fullName;
  final int age;
  final String gender;
  final String maritalStatus;
  final double income;

  PersonModel({
    required this.fullName,
    required this.age,
    required this.gender,
    required this.maritalStatus,
    required this.income,
  });

  @override
  String toString() {
    return 'PersonModel(\n'
        '  fullName: $fullName,\n'
        '  age: $age,\n'
        '  gender: $gender,\n'
        '  maritalStatus: $maritalStatus,\n'
        '  income: ${income.toStringAsFixed(0)} tr VND\n'
        ')';
  }
}