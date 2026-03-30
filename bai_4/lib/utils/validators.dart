import 'package:flutter/material.dart';
class Validators {
  static String? validateDate(DateTime? date) {
    if (date == null) {
      return 'Vui lòng chọn ngày';
    }
    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);
    final selectedOnly = DateTime(date.year, date.month, date.day);
    if (selectedOnly.isBefore(todayOnly)) {
      return 'Ngày không hợp lệ (trong quá khứ)';
    }
    return null;
  }

  static String? validateTime(TimeOfDay? time) {
    if (time == null) {
      return 'Vui lòng chọn giờ';
    }
    return null;
  }

  static String? validateService(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng chọn dịch vụ';
    }
    return null;
  }
}