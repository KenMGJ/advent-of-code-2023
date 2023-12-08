import 'package:dart_numerics/dart_numerics.dart';

import 'challenges.dart';

class LeftRight {
  String left;
  String right;

  LeftRight(this.left, this.right);

  @override
  String toString() {
    return 'LeftRight{left: $left, right: $right}';
  }
}

class Challenge2023Day08 implements Challenge {

  late List<String> directions;
  late Map<String, LeftRight> map;

  @override
  String partOne(List<String> lines) {
    parseInput(lines);

    int steps = 0;
    var current = 'AAA';
    while (current != 'ZZZ') {
      final dir = directions.removeAt(0);
      current = dir == 'L' ? map[current]!.left : map[current]!.right;
      directions.add(dir);
      steps++;
    }

    return steps.toString();
  }

  @override
  String partTwo(List<String> lines) {
    parseInput(lines);

    var currents = map.keys.where((k) => k.endsWith('A')).toList();
    final dirs = List<String>.from(directions);

    final List<int> steps = [];

    for (final c in currents) {

      int step = 0;
      var current = c;

      while (!current.endsWith('Z')) {
        final dir = dirs.removeAt(0);
        current = dir == 'L' ? map[current]!.left : map[current]!.right;
        dirs.add(dir);
        step++;
      }

      steps.add(step);
    }

    return leastCommonMultipleOfMany(steps).toString();
  }

  void parseInput(List<String> lines) {

    directions = [];
    map = {};

    final directionsLine = lines.removeAt(0);
    for (final d in directionsLine.split('')) {
      directions.add(d);
    }

    // remove blank line
    lines.removeAt(0);

    for (final line in lines) {
      final regexp = RegExp(r'^(.*) = \((.*), (.*)\)$');
      final match = regexp.firstMatch(line);

      map[match!.group(1)!] = LeftRight(match.group(2)!, match.group(3)!);
    }

    // print(directions);
    // print(map);
  }

}
