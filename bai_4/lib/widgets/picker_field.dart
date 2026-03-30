import 'package:flutter/material.dart';

class PickerField extends StatelessWidget {
  final String hintText;
  final String? value;
  final IconData icon;
  final String? errorText;
  final VoidCallback onTap;

  const PickerField({
    super.key,
    required this.hintText,
    required this.value,
    required this.icon,
    required this.onTap,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: hasError
                    ? Colors.red
                    : const Color(0xFFBDBDBD),
                width: hasError ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value ?? hintText,
                  style: TextStyle(
                    fontSize: 15,
                    color: value != null
                        ? const Color(0xFF1A1A1A)
                        : Colors.grey,
                  ),
                ),
                Icon(icon,
                    color: hasError ? Colors.red : Colors.grey,
                    size: 22),
              ],
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Row(
              children: [
                const Icon(Icons.error, color: Colors.red, size: 16),
                const SizedBox(width: 6),
                Text(
                  errorText!,
                  style: const TextStyle(
                      color: Colors.red, fontSize: 12),
                ),
              ],
            ),
          ),
      ],
    );
  }
}