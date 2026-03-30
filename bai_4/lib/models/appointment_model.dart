import 'package:flutter/material.dart';
class AppointmentModel {
  final DateTime date;
  final TimeOfDay time;
  final String service;

  AppointmentModel({
    required this.date,
    required this.time,
    required this.service,
  });

  String get formattedDate =>
      '${date.day.toString().padLeft(2, '0')}/'
          '${date.month.toString().padLeft(2, '0')}/'
          '${date.year}';

  String get formattedTime =>
      '${time.hour.toString().padLeft(2, '0')}:'
          '${time.minute.toString().padLeft(2, '0')}';

  @override
  String toString() {
    return 'AppointmentModel(\n'
        '  date: $formattedDate,\n'
        '  time: $formattedTime,\n'
        '  service: $service\n'
        ')';
  }
}