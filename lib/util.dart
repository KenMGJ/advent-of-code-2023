

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