

List<List<String>> parseLines(List<String> lines, String pattern, int n) {

  final regexp = RegExp(pattern);

  final newLines = List<List<String>>.empty(growable: true);

  for (final l in lines) {
    final match = regexp.firstMatch(l);
    if (match!.group(0) != null) {
      var parts = <String>[];
      for (var i = 1; i <= n; i++) {
        parts.add(match.group(i) ?? "");
      }
      newLines.add(parts);
    }
  }

  return newLines;
}

int asInt(String? val) {
  return int.tryParse(val!) ?? 0;
}

String firstWordFromLine(String line) {
  final regexp = RegExp(r'(.*)');
  final match = regexp.firstMatch(line);
  return match!.group(1)!;
}

List<int> intsFromLine(String line) {

  final regexp = RegExp(r'(\d+)');
  final matches = regexp.allMatches(line);

  List<int> values = [];
  for (final m in matches) {
    values.add(int.tryParse(m.group(1)!)!);
  }

  return values;
}