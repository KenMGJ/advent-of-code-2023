import 'challenges.dart';

class Day13Pattern {
  List<List<bool>> rows;
  int horizontalColumn = -1;
  int verticalColumn = -1;

  Day13Pattern(this.rows);

  bool hasHorizontalReflection(int n) {
    horizontalColumn = -1;

    for (int c = 0; c < rows.length - 1; c++) {
      int i = c;
      int j = c + 1;

      int count = 0;
      while (i >= 0 && j < rows.length) {
        count += countUnequalRows(i, j);
        i--;
        j++;
      }

      if (count == n) {
        horizontalColumn = c;
        break;
      }
    }

    return horizontalColumn > -1;
  }

  bool hasVerticalReflection(int n) {
    verticalColumn = -1;

    for (int c = 0; c < rows[0].length - 1; c++) {
      int i = c;
      int j = c + 1;

      int count = 0;
      while (i >= 0 && j < rows[0].length) {
        count += countUnequalColumns(i, j);
        i--;
        j++;
      }

      if (count == n) {
        verticalColumn = c;
        break;
      }
    }

    return verticalColumn > -1;
  }

  int countUnequalColumns(int column0, int column1) {
    int count = 0;
    for (int i = 0; i < rows.length; i++) {
      if (rows[i][column0] != rows[i][column1]) {
        count++;
      }
    }
    return count;
  }

  int countUnequalRows(int row0, int row1) {
    int count = 0;
    for (int i = 0; i < rows[row0].length; i++) {
      if (rows[row0][i] != rows[row1][i]) {
        count++;
      }
    }
    return count;
  }
}

class Challenge2023Day13 implements Challenge {

  late List<Day13Pattern> patterns;

  @override
  String partOne(List<String> lines) {
    return summarize(lines, 0).toString();
  }

  @override
  String partTwo(List<String> lines) {
    return summarize(lines, 1).toString();
  }

  int summarize(List<String> lines, int smudgeCount) {
    patterns = parseInput(lines);

    int sum = 0;

    for (final p in patterns) {
      if (p.hasVerticalReflection(smudgeCount)) {
        sum += p.verticalColumn + 1;
      } else if (p.hasHorizontalReflection(smudgeCount)) {
        sum += 100 * ( p.horizontalColumn + 1 );
      }
    }

    return sum;
  }

  List<Day13Pattern> parseInput(List<String> lines) {
    List<Day13Pattern> lps = [];

    List<List<bool>> current = [];
    for (final line in lines) {
      if (line.isEmpty) {
        lps.add(Day13Pattern(current));
        current = [];
      } else {

        List<bool> val = [];
        for (final s in line.split('')) {
          val.add(s == '#');
        }
        current.add(val);
      }
    }
    lps.add(Day13Pattern(current));

    return lps;
  }
}
