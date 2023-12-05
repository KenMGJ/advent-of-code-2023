import 'package:advent_of_code_2023/util.dart';

import 'challenges.dart';

class Day05Range {
  int offset;
  int min;
  int max;

  Day05Range(this.offset, this.min, this.max);

  bool inRange(int val) {
    return min <= val && val <= max;
  }

  int destValue(int val) {
    return val - offset;
  }

  @override
  String toString() {
    return 'Day05Range{offset: $offset, min: $min, max: $max}';
  }

  Day05Range reverse() {
    return Day05Range(offset * -1, min - offset, max - offset - 1);
  }
}

class Day05Entry {
  String dest;
  List<Day05Range> ranges;

  Day05Entry(this.dest, this.ranges);

  @override
  String toString() {
    return 'Day05Entry{dest: $dest, ranges: $ranges}';
  }
}

class Challenge2023Day05 implements Challenge {

  List<int> seeds = [];
  Map<String, Day05Entry> map = {};

  @override
  String partOne(List<String> lines) {

    map = parseInput(lines);
    var value = -1;

    for (final seed in seeds) {
      var src = 'seed';
      var current = seed;
      while(map.containsKey(src)) {
        final value = map[src]!;
        src = value.dest;
        for (final r in value.ranges) {
          if (r.inRange(current)) {
            current = r.destValue(current);
            break;
          }
        }
      }

      if (value == -1 || value > current) {
        value = current;
      }
    }

    return value.toString();
  }

  @override
  String partTwo(List<String> lines) {
    map = parseInput(lines);
    final rev = reverseMap(map);

    List<Day05Range> seedRanges = [];
    for (int i = 0; i < seeds.length; i += 2) {
      seedRanges.add(Day05Range(0, seeds[i], seeds[i] + seeds[i+1]));
    }
    // print(seedRanges);

    bool found = false;

    int seed = 1;
    var current = seed;

    while (!found) {
      var src = 'location';
      current = seed;
      while(rev.containsKey(src)) {
        final value = rev[src]!;
        src = value.dest;
        for (final r in value.ranges) {
          if (r.inRange(current)) {
            current = r.destValue(current);
            break;
          }
        }
      }

      for (final s in seedRanges) {
        // print('current ${s.min} ${s.max}');
        if (s.min <= current && current <= s.max) {
          found = true;
          break;
        }
      }
      if (found) {
        break;
      }
      seed++;
    }

    return seed.toString();
  }

  Map<String, Day05Entry> reverseMap(Map<String, Day05Entry> map) {
    Map<String, Day05Entry> reversedMap = {};

    for (final e in map.entries) {
      reversedMap[e.value.dest] = Day05Entry(e.key, e.value.ranges.map((e) => e.reverse()).toList());
    }

    return reversedMap;
  }

  Map<String, Day05Entry> parseInput(List<String> lines) {

    Map<String, List<Day05Range>> almanac = {};

    String key = 'seeds';

    for (final line in lines) {
      if (line == '') {
        continue;
      }

      // print(line);

      if (line.startsWith('seeds')) {
        seeds = intsFromLine(line);
      } else if (line.contains('map')) {
        key = firstWordFromLine(line);
        almanac[key] = [];
      } else {
        List<int> values = intsFromLine(line);
        almanac[key]!.add(Day05Range(values[1] - values[0], values[1], values[1] + values[2]));
      }
    }

    return parseAlmanac(almanac);
  }

  Map<String, Day05Entry> parseAlmanac(Map<String, List<Day05Range>> almanac) {

    Map<String, Day05Entry> lookup = {};

    for (final e in almanac.entries) {
      final regexp = RegExp(r'(.*)-to-(.*) map');
      final match = regexp.firstMatch(e.key);
      final source = match!.group(1)!;
      final destination = match.group(2)!;
      lookup[source] = Day05Entry(destination, e.value);
    }

    return lookup;
  }
}