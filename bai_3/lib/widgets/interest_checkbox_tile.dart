import 'package:flutter/material.dart';

class InterestCheckboxTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const InterestCheckboxTile({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xFF2196F3),
      checkColor: Colors.white,
      controlAffinity: ListTileControlAffinity.trailing,
      title: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF555555)),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}