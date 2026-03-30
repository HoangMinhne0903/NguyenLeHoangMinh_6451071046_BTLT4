class ProfileModel {
  final String fullName;
  final String email;
  final String cvFileName;
  final bool confirmed;

  ProfileModel({
    required this.fullName,
    required this.email,
    required this.cvFileName,
    required this.confirmed,
  });

  @override
  String toString() {
    return 'ProfileModel(\n'
        '  fullName: $fullName,\n'
        '  email: $email,\n'
        '  cvFile: $cvFileName,\n'
        '  confirmed: $confirmed\n'
        ')';
  }
}