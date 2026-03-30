class Validators {
  static String? validateInterests(List<String> selected) {
    if (selected.isEmpty) {
      return 'Bạn phải chọn ít nhất 1 sở thích';
    }
    return null;
  }
}