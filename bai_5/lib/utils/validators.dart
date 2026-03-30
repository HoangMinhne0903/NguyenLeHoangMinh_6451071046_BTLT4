class Validators {
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập họ và tên';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  static String? validateCvFile(String? fileName) {
    if (fileName == null || fileName.isEmpty) {
      return 'Vui lòng upload CV của bạn!';
    }
    final lower = fileName.toLowerCase();
    if (!lower.endsWith('.pdf') && !lower.endsWith('.docx')) {
      return 'Chỉ chấp nhận file PDF hoặc DOCX';
    }
    return null;
  }
}