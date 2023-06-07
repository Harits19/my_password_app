enum GenerateEnum {
  number(
    char: '1234567890',
  ),
  symbol(
    char: '`~!@#%^&*()_-+[]}|;' ",./<>?",
  ),
  letter(
    char: 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz',
  );

  const GenerateEnum({
    required this.char,
  });
  final String char;

  static final defaultChar = GenerateEnum.values.map((e) => e.char);
}
