import 'challenges.dart';
import 'direction.dart';
import 'tuple.dart';

class Day16Key {
  int row;
  int column;
  Direction direction;

  Day16Key(this.row, this.column, this.direction);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Day16Key &&
          runtimeType == other.runtimeType &&
          row == other.row &&
          column == other.column &&
          direction == other.direction;

  @override
  int get hashCode => row.hashCode ^ column.hashCode ^ direction.hashCode;
}

class Challenge2023Day16 implements Challenge {

  List<List<int>> state = [];
  List<List<String>> cave = [];

  Set<Day16Key> seen = {};

  @override
  String partOne(List<String> lines) {
    parseInput(lines);

    move(Day16Key(0, 0, Direction.right));

    return countEnergizedTiles().toString();
  }

  int countEnergizedTiles() {
    int sum = 0;
    for (final row in state) {
      for (final column in row) {
        sum += column > 0 ? 1 : 0;
      }
    }
    return sum;
  }

  @override
  String partTwo(List<String> lines) {
    parseInput(lines);

    int max = 0;

    // count downs
    for (int i = 0; i < cave[0].length; i++) {
      move(Day16Key(0, i, Direction.down));
      final count = countEnergizedTiles();
      if (count > max) {
        max = count;
      }
      reset();
    }

    // count ups
    final lastRow = cave.length - 1;
    for (int i = 0; i < cave[lastRow].length; i++) {
      move(Day16Key(lastRow, i, Direction.up));
      final count = countEnergizedTiles();
      if (count > max) {
        max = count;
      }
      reset();
    }

    // count rights
    for (int i = 0; i < cave.length; i++) {
      move(Day16Key(i, 0, Direction.right));
      final count = countEnergizedTiles();
      if (count > max) {
        max = count;
      }
      reset();
    }

    // count lefts
    final lastColumn = cave[0].length - 1;
    for (int i = 0; i < cave.length; i++) {
      move(Day16Key(i, lastColumn, Direction.left));
      final count = countEnergizedTiles();
      if (count > max) {
        max = count;
      }
      reset();
    }

    return max.toString();
  }

  void reset() {
    seen = {};
    for (int i = 0; i < state.length; i++) {
      for (int j = 0; j < state[i].length; j++) {
        state[i][j] = 0;
      }
    }
  }

  void move(final Day16Key key) {
    if (seen.contains(key)) {
      return;
    }

    seen.add(key);
    final row = key.row;
    final column = key.column;
    final direction = key.direction;

    if (row >= 0 && row < cave.length && column >= 0 && column < cave[0].length) {

      // mark energized
      state[row][column] += 1;

      String val = cave[row][column];
      if (val == '.') {
        final pair = next(row, column, direction);
        move(Day16Key(pair.left, pair.right, direction));
      } else if (val == '/') {

        var d = direction;
        switch (direction) {
          case Direction.up:
            d = Direction.right;
            break;
          case Direction.right:
            d = Direction.up;
            break;
          case Direction.down:
            d = Direction.left;
            break;
          case Direction.left:
            d = Direction.down;
        }


        final pair = next(row, column, d);
        move(Day16Key(pair.left, pair.right, d));
      } else if (val == '\\') {

        var d = direction;
        switch (direction) {
          case Direction.up:
            d = Direction.left;
            break;
          case Direction.right:
            d = Direction.down;
            break;
          case Direction.down:
            d = Direction.right;
            break;
          case Direction.left:
            d = Direction.up;
        }

        final pair = next(row, column, d);
        move(Day16Key(pair.left, pair.right, d));
      } else if (val == '|') {
        if (direction == Direction.up || direction == Direction.down) {
          final pair = next(row, column, direction);
          move(Day16Key(pair.left, pair.right, direction));
        } else {
          final pairUp = next(row, column, Direction.up);
          move(Day16Key(pairUp.left, pairUp.right, Direction.up));
          final pairDown = next(row, column, Direction.down);
          move(Day16Key(pairDown.left, pairDown.right, Direction.down));
        }
      } else if (val == '-') {
        if (direction == Direction.left || direction == Direction.right) {
          final pair = next(row, column, direction);
          move(Day16Key(pair.left, pair.right, direction));
        } else {
          final pairLeft = next(row, column, Direction.left);
          move(Day16Key(pairLeft.left, pairLeft.right, Direction.left));
          final pairRight = next(row, column, Direction.right);
          move(Day16Key(pairRight.left, pairRight.right, Direction.right));
        }
      }
    }
  }

  Pair<int, int> next(int row, int column, Direction direction) {
    int r = row;
    int c = column;

    switch (direction) {
      case Direction.up:
        r--;
        break;
      case Direction.right:
        c++;
        break;
      case Direction.down:
        r++;
        break;
      case Direction.left:
        c--;
    }

    return Pair(r, c);
  }

  void parseInput(List<String> lines) {
    state = [];
    cave = [];

    for (final line in lines) {
      List<int> stateRow = [];
      List<String> caveRow = [];
      for (final char in line.split('')) {
        stateRow.add(0);
        caveRow.add(char);
      }
      state.add(stateRow);
      cave.add(caveRow);
    }
  }

}