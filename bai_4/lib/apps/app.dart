import 'package:flutter/material.dart';
import '../views/appointment_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Đặt Lịch Hẹn',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2D6A6A),
          primary: const Color(0xFF2D6A6A),
        ),
        useMaterial3: true,
      ),
      home: const AppointmentScreen(),
    );
  }
}