import 'dart:math';
import 'challenges.dart';

class Challenge2022Day01 implements Challenge {

  @override
  String partOne(List<String> lines) {
    final entries = makeMap(lines);
    final max = getMax(entries);
    return max[1].toString();
  }

  @override
  String partTwo(List<String> lines) {
    final calories = makeMap(lines);

    List<int> max = getMax(calories);
    int maxElf = max[0];
    int maxCal = max[1];

    int maxThreeCal = maxCal;

    calories.remove(maxElf);
    max = getMax(calories);
    maxElf = max[0];
    maxCal = max[1];
    maxThreeCal += maxCal;

    calories.remove(maxElf);
    max = getMax(calories);
    maxElf = max[0];
    maxCal = max[1];
    maxThreeCal += maxCal;

    return maxThreeCal.toString();
  }

  Map<int, int> makeMap(List<String> entries) {
    var elf = 1;
    var calories = <int, int>{};

    for (final e in entries) {
      if (e == '') {
        elf += 1;
      } else {
        final cals = calories[elf] ?? 0;
        calories[elf] = cals + (int.tryParse(e) ?? 0);
      }
    }

    return calories;
  }

  List<int> getMax(Map<int, int> cals) {

    int maxElf = 0;
    int maxCal = 0;

    cals.forEach((elf, cal) {
      maxCal = max(maxCal, cal);
      if (maxCal == cal) {
        maxElf = elf;
      }
    });

    return [ maxElf, maxCal ];
  }
}