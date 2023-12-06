import 'challenges.dart';

class Challenge2023Day06 implements Challenge {

  late List<int> times;
  late List<int> distances;

  @override
  String partOne(List<String> lines) {
    parseInput(lines);

    // print(times);
    // print(distances);

    int record = 1;

    for (int t = 0; t < times.length; t++) {
      int wins = 0;
      final time = times[t];
      for (int i = 0; i < time; i++) {
        final distance = calcDistance(i, time);
        if (distance > distances[t]) {
          wins++;
        }
      }

      record *= wins;
    }

    return record.toString();
  }

  @override
  String partTwo(List<String> lines) {
    parseInputPart2(lines);

    // print(times);
    // print(distances);

    int wins = 0;
    final time = times[0];
    for (int i = 0; i < time; i++) {
      // print('$i of $time');
      final distance = calcDistance2(i, time);
      if (distance > distances[0]) {
        wins++;
      }
    }

    return wins.toString();
  }

  int calcDistance(int hold, int total) {

    int speed = 0;
    for (int i = 0; i < hold; i++) {
      speed++;
    }

    int distance = 0;
    for (int i = hold; i < total; i++) {
      distance += speed;
    }

    return distance;
  }

  int calcDistance2(int hold, int total) {
    return -1 * ( (hold * hold) - (hold * total) );
  }

  void parseInput(List<String> lines) {
    times = [];
    distances = [];

    for (final line in lines) {
      final regexp = RegExp(r'(\d+)');
      final matches = regexp.allMatches(line);

      for (final match in matches) {
        final value =int.tryParse(match.group(1)!)!;
        if (line.startsWith('Time:')) {
          times.add(value);
        } else if (line.startsWith('Distance:')) {
          distances.add(value);
        }
      }
    }
  }

  void parseInputPart2(List<String> lines) {
    times = [];
    distances = [];

    for (final line in lines) {
      final regexp = RegExp(r'(\d+)');
      final matches = regexp.allMatches(line);

      var value = '';
      for (final match in matches) {
        value += match.group(1)!;
      }

      int val = int.tryParse(value)!;
      if (line.startsWith('Time:')) {
        times.add(val);
      } else if (line.startsWith('Distance:')) {
        distances.add(val);
      }
    }
  }

}