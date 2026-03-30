class Validators {
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập họ và tên';
    }
    return null;
  }

  static String? validateAge(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập tuổi';
    }
    final age = int.tryParse(value.trim());
    if (age == null) {
      return 'Tuổi phải là số nguyên';
    }
    if (age <= 0) {
      return 'Tuổi phải > 0';
    }
    if (age > 120) {
      return 'Tuổi không hợp lệ';
    }
    return null;
  }
}