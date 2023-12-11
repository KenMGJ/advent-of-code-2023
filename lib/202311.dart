import 'dart:io';
import 'dart:math';

import 'package:advent_of_code_2023/point3d.dart';

import 'challenges.dart';

const factor = 1000000;

class Challenge2023Day11 implements Challenge {

  late List<List<int>> unexpanded;
  late Set<int> zeroRows;
  late Set<int> zeroColumns;

  late List<List<int>> map;
  late List<Point<int>> points;
  late List<Point<int>> unexpandedPoints;

  @override
  String partOne(List<String> lines) {
    parseInput(lines);

    int sum = 0;
    for (int i = 0; i < points.length - 1; i++) {
      for (int j = i + 1; j < points.length; j++) {
        final p0 = points[i];
        final p1 = points[j];
        final dist = p0.manhattanDistanceTo(p1).toInt();
        // print('$p0 $p1 $dist');
        sum += dist;
      }
    }

    return sum.toString();
  }

  @override
  String partTwo(List<String> lines) {

    int sum = 0;

    for (int i = 0; i < unexpandedPoints.length - 1; i++) {
      for (int j = i + 1; j < unexpandedPoints.length; j++) {
        final p0 = unexpandedPoints[i];
        final p1 = unexpandedPoints[j];
        // final dist = p0.manhattanDistanceTo(p1).toInt();

        final minX = p0.x < p1.x ? p0.x : p1.x;
        final maxX = p0.x > p1.x ? p0.x : p1.x;
        final minY = p0.y < p1.y ? p0.y : p1.y;
        final maxY = p0.y > p1.y ? p0.y : p1.y;
        // print('$minX $maxX $minY $maxY');

        int dist = 0;
        int cross = 0;

        for (int i = minX; i < maxX; i++) {
          dist++;
          if (zeroColumns.contains(i)) {
            cross++;
          }
        }

        for (int i = minY; i < maxY; i++) {
          dist++;
          if (zeroRows.contains(i)) {
            cross++;
          }
        }

        final newDist = (dist - cross) + (factor * cross);
        sum += newDist;
        // print('$p0 $p1 $dist $cross $newDist');
      }
    }

    return sum.toString();
  }

  void parseInput(List<String> lines) {
    map = [];
    points = [];

    int count = 1;
    for (int i = 0; i < lines.length; i++) {
      List<int> newLine = [];
      final line = lines[i];
      for (int j = 0; j < line.length; j++) {
        if (line[j] == '#') {
          newLine.add(count);
          count++;
        } else {
          newLine.add(0);
        }
      }
      map.add(newLine);
    }

    unexpanded = [];
    unexpandedPoints = [];
    for (int i = 0; i < map.length; i++) {
      final row = map[i];
      final List<int> newRow = [];
      for (int j = 0; j < row.length; j++) {
        newRow.add(row[j]);
      }
      unexpanded.add(newRow);
    }

    for (int y = 0; y < unexpanded.length; y++) {
      final row = unexpanded[y];
      for (int x = 0; x < row.length; x++) {
        if (row[x] > 0) {
          unexpandedPoints.add(Point(x, y));
        }
      }
    }

    zeroRows = {};
    for (int i = 0; i < map.length; i++) {
      int sum = map[i].reduce((value, element) => value + element);
      if (sum == 0) {
        zeroRows.add(i);
      }
    }

    List<int> zeroColumnsList = [];
    zeroColumns = {};
    for (int j = 0; j < map[0].length; j++) {
      int sum = 0;
      for (int i = 0; i < map.length; i++) {
        sum += map[i][j];
      }
      if (sum == 0) {
        zeroColumnsList.add(j);
        zeroColumns.add(j);
      }
    }

    for (int i = map.length - 1; i >= 0; i--) {
      if (zeroRows.contains(i)) {
        List<int> newRow = [];
        for (int j = 0; j < map[i].length; j++) {
          newRow.add(0);
        }
        map.insert(i, newRow);
      }
    }

    for (final row in map) {
      for (final c in zeroColumnsList.reversed) {
        row.insert(c, 0);
      }
    }
    // printMap(map);

    for (int y = 0; y < map.length; y++) {
      final row = map[y];
      for (int x = 0; x < row.length; x++) {
        if (row[x] > 0) {
          points.add(Point(x, y));
        }
      }
    }
  }

  void printMap(List<List<int>> map) {
    for (int i = 0; i < map.length; i++) {
      final row = map[i];
      for (int j = 0; j < row.length; j++) {
        if (row[j] > 0) {
          stdout.write(row[j]);
        } else {
          stdout.write('.');
        }
      }
      print('');
    }
  }

}