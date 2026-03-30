class SurveyModel {
  final List<String> selectedInterests;
  final String satisfactionLevel;
  final String notes;

  SurveyModel({
    required this.selectedInterests,
    required this.satisfactionLevel,
    required this.notes,
  });

  @override
  String toString() {
    return 'SurveyModel(\n'
        '  interests: ${selectedInterests.join(', ')},\n'
        '  satisfaction: $satisfactionLevel,\n'
        '  notes: $notes\n'
        ')';
  }
}