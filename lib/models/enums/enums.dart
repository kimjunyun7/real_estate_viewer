enum DialogItemType {
  city('city', '지역'),
  gu('gu', '구'),
  date('date', '날짜');

  const DialogItemType(this.code, this.displayName);
  final String code;
  final String displayName;

  factory DialogItemType.getByCode(String code) {
    return DialogItemType.values.firstWhere((value) => value.code == code);
  }
}
