import 'challenges.dart';

class Challenge2023Day09 implements Challenge {

  @override
  String partOne(List<String> lines) {
    final parsedLines = parseInput(lines);

    int sum = calculate(parsedLines);
    return sum.toString();
  }

  @override
  String partTwo(List<String> lines) {
    final parsedLines = parseInput(lines);

    List<List<int>> reversed = [];
    for (final l in parsedLines) {
      reversed.add(List<int>.from(l.reversed));
    }

    int sum = calculate(reversed);
    return sum.toString();
  }

  int calculate(List<List<int>> input) {

    int sum = 0;

    for (final l in input) {

      List<List<int>> history = [];
      history.add(List<int>.from(l));

      var current = history[0];
      while (isNotZeros(current)) {
        final List<int> newList = [];
        for (int i = 1; i < current.length; i++) {
          newList.add(current[i] - current[i-1]);
        }
        history.add(newList);
        current = newList;
      }

      history.last.add(0);
      for (int i = history.length - 2; i >= 0; i--) {
        history[i].add(history[i+1].last + history[i].last);
      }

      sum += history[0].last;
    }

    return sum;
  }

  bool isNotZeros(List<int> values) {
    for (final v in values) {
      if (v != 0) {
        return true;
      }
    }
    return false;
  }

  List<List<int>> parseInput(List<String> lines) {
    final List<List<int>> list = [];

    for (final line in lines) {
      final List<int> l = [];

      final regexp = RegExp(r'(-?\d+)');
      final matches = regexp.allMatches(line);
      for (final match in matches) {
        l.add(int.tryParse(match.group(1)!)!);
      }

      list.add(l);
    }

    return list;
  }
}
