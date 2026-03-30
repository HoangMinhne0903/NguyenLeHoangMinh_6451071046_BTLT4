import 'package:flutter/material.dart';
import '../utils/validators.dart';
import '../models/user_model.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _agreedToTerms = false;
  bool _isFormValid = false;

  bool _nameValid = false;
  bool _emailValid = false;
  bool _passwordValid = false;

  static const String mssv = '6451071046';
  static const String studentName = 'Nguyễn Lê Hoàng Minh';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _checkFormValidity() {
    setState(() {
      _nameValid = Validators.validateFullName(_nameController.text) == null;
      _emailValid = Validators.validateEmail(_emailController.text) == null;
      _passwordValid =
          Validators.validatePassword(_passwordController.text) == null;
      _isFormValid =
          _nameValid && _emailValid && _passwordValid && _agreedToTerms;
    });
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate() && _agreedToTerms) {
      final user = UserModel(
        fullName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        agreedToTerms: _agreedToTerms,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Đăng ký thành công!\n${user.fullName} - ${user.email}'),
          backgroundColor: const Color(0xFF2D6A6A),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D6A6A),
        title: const Text(
          'Đăng Ký Tài Khoản',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Đã có tài khoản?',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
                Text(
                  'Đăng nhập',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),

                // MSSV & Tên sinh viên
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D6A6A).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: const Color(0xFF2D6A6A).withOpacity(0.3)),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'MSSV: $mssv',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D6A6A),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'SV: $studentName',
                        style: TextStyle(
                          color: Color(0xFF2D6A6A),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Avatar
                const Icon(
                  Icons.account_circle,
                  size: 80,
                  color: Color(0xFF2D6A6A),
                ),
                const SizedBox(height: 24),

                // Họ và tên
                CustomTextField(
                  label: 'Họ và tên',
                  hint: 'Nguyễn Văn A',
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  validator: Validators.validateFullName,
                  onChanged: (_) => _checkFormValidity(),
                  suffixIcon: _nameValid
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                ),
                const SizedBox(height: 16),

                // Email
                CustomTextField(
                  label: 'Email',
                  hint: 'example@domain.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                  onChanged: (_) => _checkFormValidity(),
                  suffixIcon: _emailValid
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                ),
                const SizedBox(height: 16),

                // Mật khẩu
                CustomTextField(
                  label: 'Mật khẩu',
                  hint: '••••••••',
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  validator: Validators.validatePassword,
                  onChanged: (_) => _checkFormValidity(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Checkbox điều khoản
                Row(
                  children: [
                    Checkbox(
                      value: _agreedToTerms,
                      onChanged: (value) {
                        setState(() {
                          _agreedToTerms = value ?? false;
                          _checkFormValidity();
                        });
                      },
                      activeColor: const Color(0xFF2D6A6A),
                    ),
                    const Expanded(
                      child: Text(
                        'Tôi đồng ý với các Điều khoản & Chính sách',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Nút Đăng Ký
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isFormValid ? _onSubmit : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE8A04A),
                      disabledBackgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Đăng Ký',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _isFormValid ? Colors.white : Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}