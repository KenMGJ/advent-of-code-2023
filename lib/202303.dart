import 'challenges.dart';

class Challenge2023Day03 implements Challenge {

  Map<String, List<String>> possibleGearSet = <String, List<String>>{};

  @override
  String partOne(List<String> lines) {

    List<int> partSet = <int>[];

    for (int i = 0; i < lines.length; i++) {

      final line = lines[i];
      // print(line);

      final regexp = RegExp(r'(\d+)');

      final matches = regexp.allMatches(line);
      int savedIdx = 0;
      for (final match in matches) {
        final val = match.group(1);
        // print(val);

        final idx = line.indexOf(val!, savedIdx);
        savedIdx = idx + val.length;
        // print(idx);

        final minI = i == 0 ? i : i - 1;
        final maxI = i == lines.length - 1 ? i : i + 1;
        final minJ = idx == 0 ? idx : idx - 1;
        final maxJ = idx + val.length >= line.length - 1 ? line.length - 1 : idx + val.length;

        var found = false;
        var v = '';
        for (int a = minI; a <= maxI; a++) {
          for (int b = minJ; b <= maxJ; b++) {
            v = lines[a][b];
            if (v != '.') {
              if ((int.tryParse(v) ?? -1) == -1) {
                found = true;

                final setKey = '$a,$b';
                if (v == '*') {
                  if (!possibleGearSet.containsKey(setKey)) {
                    possibleGearSet[setKey] = [];
                  }
                  possibleGearSet[setKey]!.add(val);
                }

                break;
              }
            }
          }

          if (found) {
            break;
          }
        }

        if (found) {
          // print('\t$val $v');

          int num = int.tryParse(val)!;
          partSet.add(num);
        } else {
          // print('NO: $val');
        }
      }
    }

    int sum = 0;
    for (final part in partSet) {
      sum += part;
    }

    return sum.toString();
  }

  @override
  String partTwo(List<String> lines) {

    int sum = 0;

    for (final v in possibleGearSet.values) {
      if (v.length == 2) {
        int ratio = 1;
        for (final p in v) {
          int num = int.tryParse(p)!;
          ratio *= num;
        }
        sum += ratio;
      }
    }

    return sum.toString();
  }
}