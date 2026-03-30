import 'package:flutter/material.dart';
import '../models/survey_model.dart';
import '../utils/validators.dart';
import '../widgets/section_header.dart';
import '../widgets/interest_checkbox_tile.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  static const String mssv = '6451071046';
  static const String studentName = 'Nguyễn Lê Hoàng Minh';

  // ── Interests ─────────────────────────────────────────────
  final List<Map<String, dynamic>> _interests = [
    {'label': 'Phim ảnh (Movies)',  'icon': Icons.movie,         'checked': false},
    {'label': 'Thể thao (Sports)',  'icon': Icons.sports_soccer,  'checked': false},
    {'label': 'Âm nhạc (Music)',    'icon': Icons.music_note,     'checked': false},
    {'label': 'Du lịch (Travel)',   'icon': Icons.luggage,        'checked': false},
    {'label': 'Đọc sách (Reading)', 'icon': Icons.menu_book,      'checked': false},
    {'label': 'Nấu ăn (Cooking)',   'icon': Icons.restaurant,     'checked': false},
  ];

  // ── Satisfaction ───────────────────────────────────────────
  final List<Map<String, dynamic>> _satisfactionOptions = [
    {'label': 'Hài lòng (Satisfied)',        'icon': Icons.sentiment_satisfied},
    {'label': 'Bình thường (Neutral)',        'icon': Icons.sentiment_neutral},
    {'label': 'Chưa hài lòng (Unsatisfied)', 'icon': Icons.sentiment_dissatisfied},
  ];
  String _selectedSatisfaction = 'Hài lòng (Satisfied)';

  // ── Notes ──────────────────────────────────────────────────
  final _notesController = TextEditingController();

  // ── Validation ─────────────────────────────────────────────
  String? _interestError;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  List<String> get _selectedInterests => _interests
      .where((i) => i['checked'] == true)
      .map((i) => i['label'] as String)
      .toList();

  void _onSubmit() {
    final error = Validators.validateInterests(_selectedInterests);
    setState(() => _interestError = error);

    if (error != null) return;

    final survey = SurveyModel(
      selectedInterests: _selectedInterests,
      satisfactionLevel: _selectedSatisfaction,
      notes: _notesController.text.trim(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Gửi thành công!\n'
              'Sở thích: ${survey.selectedInterests.join(', ')}\n'
              'Mức độ: ${survey.satisfactionLevel}',
        ),
        backgroundColor: const Color(0xFF2196F3),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        title: const Text(
          'Survey',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // MSSV banner
            Container(
              width: double.infinity,
              color: const Color(0xFF2196F3).withOpacity(0.1),
              padding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: const Text(
                'MSSV: $mssv  |  SV: $studentName',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2196F3),
                ),
              ),
            ),

            // ── SỞ THÍCH ────────────────────────────────────
            const SectionHeader(
              title: 'SỞ THÍCH (INTERESTS)',
            ),
            ..._interests.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              return InterestCheckboxTile(
                label: item['label'] as String,
                icon: item['icon'] as IconData,
                value: item['checked'] as bool,
                onChanged: (val) {
                  setState(() {
                    _interests[i]['checked'] = val ?? false;
                    if (_selectedInterests.isNotEmpty) {
                      _interestError = null;
                    }
                  });
                },
              );
            }),

            // ── MỨC ĐỘ HÀI LÒNG ────────────────────────────
            const SectionHeader(
              title: 'MỨC ĐỘ HÀI LÒNG (SATISFACTION LEVEL)',
            ),
            ..._satisfactionOptions.map((option) {
              final label = option['label'] as String;
              final icon = option['icon'] as IconData;
              return RadioListTile<String>(
                value: label,
                groupValue: _selectedSatisfaction,
                onChanged: (val) =>
                    setState(() => _selectedSatisfaction = val!),
                activeColor: const Color(0xFF2196F3),
                title: Row(
                  children: [
                    Icon(icon, size: 20, color: const Color(0xFF888888)),
                    const SizedBox(width: 10),
                    Text(label, style: const TextStyle(fontSize: 15)),
                  ],
                ),
              );
            }),

            // ── Validate error ───────────────────────────────
            if (_interestError != null)
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 4),
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error,
                        color: Colors.red, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Validate',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            _interestError!,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // ── GHI CHÚ THÊM ────────────────────────────────
            const SectionHeader(
              title: 'GHI CHÚ THÊM (ADDITIONAL NOTES)',
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _notesController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Ghi chú thêm...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(12),
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
                    borderSide: const BorderSide(
                        color: Color(0xFF2196F3), width: 2),
                  ),
                ),
              ),
            ),

            // ── Submit button ────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Gửi Khảo Sát',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}