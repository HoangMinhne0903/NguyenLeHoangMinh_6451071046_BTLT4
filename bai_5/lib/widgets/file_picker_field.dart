import 'package:flutter/material.dart';

class FilePickerField extends StatelessWidget {
  final String? fileName;
  final String? errorText;
  final VoidCallback onPick;

  const FilePickerField({
    super.key,
    required this.fileName,
    required this.onPick,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null && errorText!.isNotEmpty;
    final hasFile = fileName != null && fileName!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Button row
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: hasError ? Colors.red : const Color(0xFFBDBDBD),
              width: hasError ? 1.5 : 1,
            ),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Row(
            children: [
              // Pick button
              InkWell(
                onTap: onPick,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(7),
                  bottomLeft: Radius.circular(7),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border(
                      right: BorderSide(
                        color: hasError
                            ? Colors.red
                            : const Color(0xFFBDBDBD),
                      ),
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(7),
                      bottomLeft: Radius.circular(7),
                    ),
                  ),
                  child: const Text(
                    'Chọn Tệp CV',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ),
              ),

              // File name display
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: hasFile
                      ? Row(
                    children: [
                      const Icon(
                        Icons.picture_as_pdf,
                        color: Colors.red,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          fileName!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                    ],
                  )
                      : const Text(
                    'Chưa chọn file',
                    style: TextStyle(
                        fontSize: 13, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Error text
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              errorText!,
              style:
              const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}