import 'dart:math';

import 'challenges.dart';
import 'util.dart';

const pattern = r'^(.) (.)$';

const points = { "A": 1, "B": 2, "C": 3, "X": 1, "Y": 2, "Z": 3, };
const Map<String, Map<String, int>> winPoints = {
  "X": { "A": 3, "B": 0, "C": 6, },
  "Y": { "A": 6, "B": 3, "C": 0, },
  "Z": { "A": 0, "B": 6, "C": 3, },
};

const Map<String, Map<String, List<int>>> outcome = {
  "X": { "A": [3, 0], "B": [1, 0], "C": [2, 0], },
  "Y": { "A": [1, 3], "B": [2, 3], "C": [3, 3], },
  "Z": { "A": [2, 6], "B": [3, 6], "C": [1, 6], },
};

class Challenge2022Day02 implements Challenge {

  @override
  String partOne(List<String> lines) {
    final parsedLines = parseLines(lines, pattern, 2);

    var total = 0;

    for (final l in parsedLines) {
      total += points[l[1]]! + winPoints[l[1]]![l[0]]!;
    }

    return total.toString();
  }

  @override
  String partTwo(List<String> lines) {
    final parsedLines = parseLines(lines, pattern, 2);

    var total = 0;

    for (final l in parsedLines) {
      final pick = outcome[l[1]]![l[0]]!;
      total += pick[0] + pick[1];
    }

    return total.toString();
  }
}
