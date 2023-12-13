import 'challenges.dart';

import 'package:collection/collection.dart';

Function eq = const ListEquality().equals;
Function hash = const ListEquality().hash;

class Day12CacheKey {
  String string;
  List<int> groups;

  Day12CacheKey(this.string, this.groups);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Day12CacheKey &&
          runtimeType == other.runtimeType &&
          string == other.string &&
          eq(groups, groups);

  @override
  int get hashCode => string.hashCode ^ hash(groups);
}

class Challenge2023Day12 implements Challenge {

  Map<Day12CacheKey, int> cache = {};

  @override
  String partOne(List<String> lines) {
    return calculate(lines).toString();
  }

  @override
  String partTwo(List<String> lines) {
    return calculate(expandLines(lines)).toString();
  }

  int calculate(List<String> lines) {

    int count = 0;

    for (final line in lines) {

      final regexp = RegExp(r'^(.*) (.*)$');
      final match = regexp.firstMatch(line);

      if (match != null) {
        final arrangement = match.group(1)!;
        final groups = match.group(2)!.split(',').map((e) => int.tryParse(e) ?? 0).toList();

        count += countPermutations(arrangement, groups);
      }
    }

    return count;
  }

  List<String> expandLines(List<String> lines) {
    final List<String> newLines = [];

    for (final line in lines) {
      final regexp = RegExp(r'^(.*) (.*)$');
      final match = regexp.firstMatch(line);

      if (match != null) {
        final arrangement = match.group(1)!;
        final groups = match.group(2)!;
        // print('$arrangement $groups');

        var newArrangement = arrangement;
        for (int i = 1; i < 5; i++) {
          newArrangement += '?$arrangement';
        }

        var newGroups = groups;
        for (int i = 1; i < 5; i++) {
          newGroups += ',$groups';
        }

        newLines.add('$newArrangement $newGroups');
      }
    }

    // print(newLines);
    return newLines;
  }

  int countPermutations(String input, List<int> groups) {

    final key = Day12CacheKey(input, groups);
    if (cache.containsKey(key)) {
      return cache[key]!;
    }

    if (input.isEmpty) {
      return groups.isEmpty ? 1 : 0;
    }

    final firstChar = input[0];
    int permutations = 0;
    if (firstChar == '.') {
      permutations = countPermutations(input.substring(1), groups);
    } else if (firstChar == '?') {
      permutations = countPermutations('.${input.substring(1)}', groups) + countPermutations("#${input.substring(1)}", groups);
    } else {
      if (groups.isEmpty) {
        permutations = 0;
      } else {
        int damaged = groups[0];

        bool allMatch = true;
        int i = 0;
        for (final s in input.split('')) {
          if (i >= damaged) {
            break;
          }

          if (s != '#' && s != '?') {
            allMatch = false;
            break;
          }
          i++;
        }

        if (damaged <= input.length && allMatch) {
          List<int> newGroups = List<int>.from(groups.slice(1));
          if (damaged == input.length) {
            permutations = newGroups.isEmpty ? 1 : 0;
          } else if (input[damaged] == '.') {
            permutations = countPermutations(input.substring(damaged + 1), newGroups);
          } else if (input[damaged] == '?') {
            permutations = countPermutations('.${input.substring(damaged + 1)}', newGroups);
          } else {
            permutations = 0;
          }
        } else {
          permutations = 0;
        }
      }
    }

    cache[key] = permutations;
    return permutations;
  }

}