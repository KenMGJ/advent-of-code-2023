import 'dart:io';

import 'challenges.dart';

class Day10LineAndChar {
  int line;
  int char;

  Day10LineAndChar(this.line, this.char);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Day10LineAndChar &&
          runtimeType == other.runtimeType &&
          line == other.line &&
          char == other.char;

  @override
  int get hashCode => line.hashCode ^ char.hashCode;
}

class Challenge2023Day10 implements Challenge {

  late int lineCount;
  late int charCount;

  late Set<String> ground;
  late Map<String, Set<String>> nodes;
  late String start;

  late Set<String> partOfLoop;

  @override
  String partOne(List<String> lines) {
    parseInput(lines);

    int count = 1;
    partOfLoop = {};

    var previous = start;
    partOfLoop.add(start);

    var current = nodes[start]!.first;

    while (current != start) {

      partOfLoop.add(current);

      final n = nodes[current]!.firstWhere((element) => element != previous);
      previous = current;
      current = n;
      count++;

    }

    return (count ~/ 2).toString();
  }

  @override
  String partTwo(List<String> lines) {

    Set<String> toRemove = {};
    for (final n in nodes.keys) {
      if (!partOfLoop.contains(n)) {
        ground.add(n);
        toRemove.add(n);
      }
    }
    nodes.removeWhere((key, value) => toRemove.contains(key));

    Set<String> insideNodes = {};

    int count = 0;
    for (int i = 0; i < lineCount; i++) {
      bool insideLoop = false;
      for (int j = 0; j < charCount; j++) {
        final pipe = pipeToString(i + 1, j + 1);
        final north = pipeToString(i, j + 1);
        if (nodes.containsKey(pipe)) {
          if (nodes[pipe]!.contains(north)) {
            insideLoop = !insideLoop;
          }
        } else {
          if (insideLoop) {
            insideNodes.add(pipe);
            count++;
          }
        }
      }
    }

    // printMap(insideNodes);

    return count.toString();
  }

  void printMap(Set<String> insideNodes) {
    for (int i = 0; i < lineCount; i++) {
      for (int j = 0; j < charCount; j++) {
        final pipe = pipeToString(i + 1, j + 1);
        if (nodes.keys.contains(pipe)) {
          stdout.write('.');
        } else {
          if (!insideNodes.contains(pipe)) {
            stdout.write(' ');
          } else {
            stdout.write('@');
          }
        }
      }
      print('');
    }
  }

  void parseInput(List<String> lines) {

    ground = {};
    nodes = {};

    lineCount = lines.length;

    for (int i = 0; i < lineCount; i++) {
      final line = lines[i].split('');
      charCount = line.length;
      for (int j = 0; j < charCount; j++) {

        final l = i + 1;
        final c = j + 1;

        final node = pipeToString(l, c);
        final north = pipeToString(l-1, c);
        final south = pipeToString(l+1, c);
        final east = pipeToString(l, c+1);
        final west = pipeToString(l, c-1);

        switch (line[j]) {
          case '|':
            nodes[node] = { north, south };
            break;
          case '-':
            nodes[node] = { east, west };
            break;
          case 'L':
            nodes[node] = { north, east };
            break;
          case 'J':
            nodes[node] = { north, west };
            break;
          case '7':
            nodes[node] = { south, west };
            break;
          case 'F':
            nodes[node] = { south, east };
            break;
          case '.':
            ground.add(node);
            break;
          case 'S':
            start = node;
            break;
        }
      }
    }

    nodes[start] = neighbors(start);
  }

  String pipeToString(int line, int char) {
    return '$line,$char';
  }

  Day10LineAndChar toLineAndChar(String node) {
    final regexp = RegExp(r'(\d+),(\d+)');
    final matches = regexp.firstMatch(node);

    int l = int.tryParse(matches!.group(1)!)!;
    int c = int.tryParse(matches.group(2)!)!;

    return Day10LineAndChar(l, c);
  }

  Set<String> neighbors(String node) {

    Set<String> neighbors = {};

    final lineAndChar = toLineAndChar(node);
    final l = lineAndChar.line;
    final c = lineAndChar.char;

    final north = pipeToString(l-1, c);
    if (nodes[north] != null && nodes[north]!.contains(node)) {
      neighbors.add(north);
    }

    final south = pipeToString(l+1, c);
    if (nodes[south] != null && nodes[south]!.contains(node)) {
      neighbors.add(south);
    }

    final east = pipeToString(l, c+1);
    if (nodes[east] != null && nodes[east]!.contains(node)) {
      neighbors.add(east);
    }

    final west = pipeToString(l, c-1);
    if (nodes[west] != null && nodes[west]!.contains(node)) {
      neighbors.add(west);
    }

    return neighbors;
  }
}