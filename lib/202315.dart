import 'challenges.dart';
import 'tuple.dart';

class Challenge2023Day15 implements Challenge {

  @override
  String partOne(List<String> lines) {
    int sum = 0;
    for (final line in lines) {
      for (final l in line.split(',')) {
        sum += hash(l);
      }
    }
    return sum.toString();
  }

  int hash(String line) {
    int current = 0;
    for (int i = 0; i < line.length; i++) {
      int val = line.codeUnitAt(i);
      current += val;
      current *= 17;
      current = current % 256;
    }
    return current;
  }

  @override
  String partTwo(List<String> lines) {

    List<List<Pair<String, int>>> boxes = [];
    for (int i = 0; i < 256; i++) {
      boxes.add([]);
    }

    for (final line in lines) {
      for (final l in line.split(',')) {

        if (l.contains('=')) {

          final idx = l.lastIndexOf('=');
          final key = l.substring(0, idx);
          final box = hash(key);

          final val = int.tryParse(l.substring(idx + 1))!;

          bool replaced = false;
          for (final p in boxes[box]) {
            if (p.left == key) {
              p.right = val;
              replaced = true;
            }
          }

          if (!replaced) {
            boxes[box].add(Pair(key, val));
          }

        } else if (l.contains('-')) {
          final key = l.substring(0, l.lastIndexOf('-'));
          final box = hash(key);

          int idx = -1;
          for (int i = 0; i < boxes[box].length; i++) {
            if (boxes[box][i].left == key) {
              idx = i;
              break;
            }
          }
          if (idx > -1) {
            boxes[box].removeAt(idx);
          }
        }
      }
    }

    int power = 0;
    for (int i = 0; i < boxes.length; i++) {
      for (int j = 0; j < boxes[i].length; j++) {
        power += (i + 1) * (j + 1) * boxes[i][j].right;
      }
    }

    return power.toString();
  }
}