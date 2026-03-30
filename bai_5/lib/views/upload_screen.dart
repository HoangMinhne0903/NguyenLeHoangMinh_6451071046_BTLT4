import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import '../utils/validators.dart';
import '../widgets/section_label.dart';
import '../widgets/file_picker_field.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  static const String mssv = '6451071046';
  static const String studentName = 'Nguyễn Lê Hoàng Minh';

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  String? _cvFileName;
  String? _cvError;
  bool _confirmed = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // ── Giả lập file picker bằng Dialog ─────────────────────────
  Future<void> _pickFile() async {
    final controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nhập tên file CV'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'VD: CV_HoTen.pdf hoặc CV_HoTen.docx',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Huỷ'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2D6A6A),
            ),
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                setState(() {
                  _cvFileName = name;
                  _cvError = Validators.validateCvFile(_cvFileName);
                });
              }
              Navigator.pop(ctx);
            },
            child: const Text(
              'Xác nhận',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ── Submit ───────────────────────────────────────────────────
  void _onSubmit() {
    final formValid = _formKey.currentState!.validate();

    setState(() {
      _cvError = Validators.validateCvFile(_cvFileName);
    });

    if (!formValid || _cvError != null) return;

    if (!_confirmed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng xác nhận thông tin là chính xác!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final profile = ProfileModel(
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      cvFileName: _cvFileName!,
      confirmed: _confirmed,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Nộp hồ sơ thành công!\n'
              '${profile.fullName} — ${profile.email}\n'
              'CV: ${profile.cvFileName}',
        ),
        backgroundColor: const Color(0xFF2D6A6A),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF2D6A6A), width: 2),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D6A6A),
        leading: const Icon(Icons.menu, color: Colors.white),
        title: const Text(
          'Bài 5: Form upload hồ sơ',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Họ và tên ────────────────────────────
                    const SectionLabel(text: 'Họ và tên'),
                    TextFormField(
                      controller: _nameController,
                      validator: Validators.validateFullName,
                      decoration: _inputDecoration(
                          'Full Name', 'Nguyen Lan Huong'),
                    ),
                    const SizedBox(height: 20),

                    // ── Email ────────────────────────────────
                    const SectionLabel(text: 'Email'),
                    TextFormField(
                      controller: _emailController,
                      validator: Validators.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _inputDecoration(
                          'Hint Email', 'lanhuong.nguyen@example.com'),
                    ),
                    const SizedBox(height: 20),

                    // ── File Picker ──────────────────────────
                    const SectionLabel(
                      text: 'File Picker',
                      subtitle: 'CV (Định dạng: PDF, DOCX)',
                    ),
                    FilePickerField(
                      fileName: _cvFileName,
                      errorText: _cvError,
                      onPick: _pickFile,
                    ),
                    const SizedBox(height: 20),

                    // ── Checkbox xác nhận ────────────────────
                    Row(
                      children: [
                        Checkbox(
                          value: _confirmed,
                          onChanged: (val) {
                            setState(
                                    () => _confirmed = val ?? false);
                          },
                          activeColor: const Color(0xFF2D6A6A),
                        ),
                        const Expanded(
                          child: Text(
                            'Tôi xác nhận thông tin là chính xác.',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // ── Submit button ────────────────────────
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _onSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE8A04A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                        child: const Text(
                          'Nộp Hồ Sơ',
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
            ),
          ],
        ),
      ),
    );
  }
}