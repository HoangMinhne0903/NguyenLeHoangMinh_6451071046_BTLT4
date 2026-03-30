import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/validators.dart';
import '../models/person_model.dart';
import '../widgets/section_label.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  String _selectedGender = 'Nam';
  String _maritalStatus = 'Độc thân';
  double _income = 15;

  static const String mssv = '6451071046';
  static const String studentName = 'Nguyễn Lê Hoàng Minh';

  final List<String> _genderOptions = ['Nam', 'Nữ', 'Khác'];
  final List<String> _maritalOptions = ['Độc thân', 'Kết hôn', 'Ly hôn'];

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final person = PersonModel(
        fullName: _nameController.text.trim(),
        age: int.parse(_ageController.text.trim()),
        gender: _selectedGender,
        maritalStatus: _maritalStatus,
        income: _income,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Đã lưu!\n'
                'Tên: ${person.fullName} | Tuổi: ${person.age}\n'
                'Giới tính: ${person.gender} | HN: ${person.maritalStatus}\n'
                'Thu nhập: ${person.income.toStringAsFixed(0)} tr VND',
          ),
          backgroundColor: const Color(0xFF2D6A6A),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D6A6A),
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'FORM THÔNG TIN CÁ NHÂN',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onSave,
        backgroundColor: const Color(0xFF2D6A6A),
        child: const Icon(Icons.save, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // MSSV banner
            Container(
              width: double.infinity,
              color: const Color(0xFF2D6A6A).withOpacity(0.08),
              padding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: const Text(
                'MSSV: $mssv  |  Tên: $studentName',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D6A6A),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Họ và tên ──────────────────────────────
                    const SectionLabel(text: 'Họ và tên'),
                    TextFormField(
                      controller: _nameController,
                      validator: Validators.validateFullName,
                      decoration: _inputDecoration('Nhập tên của bạn'),
                    ),
                    const SizedBox(height: 20),

                    // ── Tuổi ───────────────────────────────────
                    const SectionLabel(text: 'Tuổi'),
                    TextFormField(
                      controller: _ageController,
                      validator: Validators.validateAge,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: _inputDecoration('Nhập tuổi của bạn'),
                    ),
                    const SizedBox(height: 20),

                    // ── Giới tính ──────────────────────────────
                    const SectionLabel(text: 'Giới tính'),
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      decoration: _inputDecoration(null),
                      items: _genderOptions
                          .map((g) => DropdownMenuItem(
                        value: g,
                        child: Text(g),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() => _selectedGender = value!);
                      },
                    ),
                    const SizedBox(height: 20),

                    // ── Tình trạng hôn nhân ────────────────────
                    const SectionLabel(text: 'Tình trạng hôn nhân'),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        children: _maritalOptions.map((status) {
                          return RadioListTile<String>(
                            title: Text(
                              status,
                              style: const TextStyle(fontSize: 15),
                            ),
                            value: status,
                            groupValue: _maritalStatus,
                            activeColor: const Color(0xFF2D6A6A),
                            dense: true,
                            onChanged: (value) {
                              setState(() => _maritalStatus = value!);
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Mức thu nhập ───────────────────────────
                    const SectionLabel(text: 'Mức thu nhập'),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Mức: ${_income.toStringAsFixed(0)} tr VND',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2D6A6A),
                            ),
                          ),
                          Slider(
                            value: _income,
                            min: 0,
                            max: 50,
                            divisions: 50,
                            activeColor: const Color(0xFF2D6A6A),
                            inactiveColor: Colors.grey.shade300,
                            onChanged: (value) {
                              setState(() => _income = value);
                            },
                          ),
                          const Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              _SliderLabel('0\ntr VND'),
                              _SliderLabel('10\ntr VND'),
                              _SliderLabel('20\ntr VND'),
                              _SliderLabel('30\ntr VND'),
                              _SliderLabel('40\ntr VND'),
                              _SliderLabel('50\ntr VND'),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String? hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
        const BorderSide(color: Color(0xFF2D6A6A), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }
}

class _SliderLabel extends StatelessWidget {
  final String text;
  const _SliderLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 10, color: Colors.grey),
    );
  }
}