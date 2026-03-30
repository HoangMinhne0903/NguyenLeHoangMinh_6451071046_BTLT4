import 'package:flutter/material.dart';
import '../models/appointment_model.dart';
import '../utils/validators.dart';
import '../widgets/section_label.dart';
import '../widgets/picker_field.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  static const String mssv = '6451071046';
  static const String studentName = 'Nguyễn Lê Hoàng Minh';

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedService;

  String? _dateError;
  String? _timeError;
  String? _serviceError;

  final List<String> _services = [
    'Kiểm tra tổng quát',
    'Tư vấn dinh dưỡng',
    'Khám chuyên khoa',
    'Xét nghiệm máu',
    'Siêu âm',
    'Vật lý trị liệu',
  ];

  // ── Date picker ─────────────────────────────────────────────
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF2D6A6A),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateError = Validators.validateDate(picked);
      });
    }
  }

  // ── Time picker ─────────────────────────────────────────────
  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF2D6A6A),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _timeError = Validators.validateTime(picked);
      });
    }
  }

  // ── Format helpers ──────────────────────────────────────────
  String? get _formattedDate {
    if (_selectedDate == null) return null;
    return '${_selectedDate!.day.toString().padLeft(2, '0')}/'
        '${_selectedDate!.month.toString().padLeft(2, '0')}/'
        '${_selectedDate!.year}';
  }

  String? get _formattedTime {
    if (_selectedTime == null) return null;
    return '${_selectedTime!.hour.toString().padLeft(2, '0')}:'
        '${_selectedTime!.minute.toString().padLeft(2, '0')}';
  }

  // ── Submit ──────────────────────────────────────────────────
  void _onConfirm() {
    setState(() {
      _dateError = Validators.validateDate(_selectedDate);
      _timeError = Validators.validateTime(_selectedTime);
      _serviceError = Validators.validateService(_selectedService);
    });

    if (_dateError != null ||
        _timeError != null ||
        _serviceError != null) return;

    final appointment = AppointmentModel(
      date: _selectedDate!,
      time: _selectedTime!,
      service: _selectedService!,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Đặt lịch thành công!\n'
              'Ngày: ${appointment.formattedDate}  '
              'Giờ: ${appointment.formattedTime}\n'
              'Dịch vụ: ${appointment.service}',
        ),
        backgroundColor: const Color(0xFF2D6A6A),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D6A6A),
        title: const Text(
          'ĐẶT LỊCH HẸN',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // MSSV banner
            Container(
              width: double.infinity,
              color: const Color(0xFF2D6A6A).withOpacity(0.08),
              padding: const EdgeInsets.symmetric(
                  vertical: 8, horizontal: 16),
              child: const Text(
                'MSSV: $mssv  |  SV: $studentName',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D6A6A),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Chọn ngày ─────────────────────────────
                  const SectionLabel(text: 'Chọn ngày'),
                  PickerField(
                    hintText: 'Select Date',
                    value: _formattedDate,
                    icon: Icons.calendar_today,
                    errorText: _dateError,
                    onTap: _pickDate,
                  ),
                  const SizedBox(height: 20),

                  // ── Chọn giờ ──────────────────────────────
                  const SectionLabel(text: 'Chọn giờ'),
                  PickerField(
                    hintText: 'Chọn giờ',
                    value: _formattedTime,
                    icon: Icons.access_time,
                    errorText: _timeError,
                    onTap: _pickTime,
                  ),
                  const SizedBox(height: 20),

                  // ── Chọn dịch vụ ──────────────────────────
                  const SectionLabel(text: 'Chọn dịch vụ'),
                  DropdownButtonFormField<String>(
                    value: _selectedService,
                    hint: const Text(
                      'Chọn dịch vụ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    items: _services
                        .map((s) => DropdownMenuItem(
                      value: s,
                      child: Text(s),
                    ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedService = val;
                        _serviceError =
                            Validators.validateService(val);
                      });
                    },
                    validator: Validators.validateService,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: Color(0xFFBDBDBD)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: _serviceError != null
                              ? Colors.red
                              : const Color(0xFFBDBDBD),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: Color(0xFF2D6A6A), width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                        const BorderSide(color: Colors.red),
                      ),
                      errorText: _serviceError,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // ── Confirm button ─────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _onConfirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE8A04A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: const Text(
                        'Xác nhận Đặt lịch',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}