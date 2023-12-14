import 'dart:io';

import 'challenges.dart';

enum Day14State {
  roundedRock(symbol: 'O'),
  cubeShapedRock(symbol: '#'),
  emptySpace(symbol: '.');

  const Day14State({
    required this.symbol,
  });

  final String symbol;
}

class Challenge2023Day14 implements Challenge {

  @override
  String partOne(List<String> lines) {
    var grid = parseInput(lines);
    grid = tiltNorth(grid);

    return calculateLoad(grid).toString();
  }

  @override
  String partTwo(List<String> lines) {
    var grid = parseInput(lines);

    final cycles = 1000;
    List<List<Day14State>> lastGrid = grid;

    for (int i = 0; i < cycles; i++) {
      grid = tiltNorth(grid);
      grid = tiltWest(grid);
      grid = tiltSouth(grid);
      grid = tiltEast(grid);
    }

    return calculateLoad(grid).toString();
  }

  BigInt calculateLoad(List<List<Day14State>> grid) {

    BigInt sum = BigInt.zero;
    int weight = grid.length;

    for (final row in grid) {
      for (final val in row) {
        if (val == Day14State.roundedRock) {
          sum = sum + BigInt.from(weight);
        }
      }
      weight--;
    }

    return sum;
  }

  List<List<Day14State>> tiltNorth(List<List<Day14State>> grid) {
    return rotateRight(rollRockLeft(rotateLeft(grid)));
  }

  List<List<Day14State>> tiltSouth(List<List<Day14State>> grid) {
    return rotateLeft(rollRockLeft(rotateRight(grid)));
  }

  List<List<Day14State>> tiltWest(List<List<Day14State>> grid) {
    return rollRockLeft(grid);
  }

  List<List<Day14State>> tiltEast(List<List<Day14State>> grid) {
    return rotateLeft(rotateLeft(rollRockLeft(rotateRight(rotateRight(grid)))));
  }

  List<List<Day14State>> rollRockLeft(List<List<Day14State>> grid) {
    List<List<Day14State>> newGrid = [];
    for (int i = 0; i < grid.length; i++) {
      List<Day14State> newRow = [];
      for (int j = 0; j < grid[i].length; j++) {
        final val = grid[i][j];

        if (val == Day14State.roundedRock) {

          int pos = j;
          for (int k = j - 1; k >= 0; k--) {
            if (newRow[k] != Day14State.emptySpace) {
              pos = k + 1;
              break;
            }

            if (k == 0) {
              pos = 0;
            }
          }

          if (pos < j) {
            newRow[pos] = Day14State.roundedRock;
            newRow.add(Day14State.emptySpace);
          } else {
            newRow.add(val);
          }

        } else {
          newRow.add(val);
        }

      }
      newGrid.add(newRow);
    }
    return newGrid;
  }

  List<List<Day14State>> rotateRight(List<List<Day14State>> grid) {
    List<List<Day14State>> newGrid = [];
    for (int i = 0; i < grid[0].length; i++) {
      List<Day14State> newRow = [];
      for (int j = grid.length - 1; j >= 0; j--) {
        newRow.add(grid[j][i]);
      }
      newGrid.add(newRow);
    }
    return newGrid;
  }

  List<List<Day14State>> rotateLeft(List<List<Day14State>> grid) {
    List<List<Day14State>> newGrid = [];
    for (int i = grid[0].length - 1; i >= 0; i--) {
      List<Day14State> newRow = [];
      for (int j = 0; j < grid.length; j++) {
        newRow.add(grid[j][i]);
      }
      newGrid.add(newRow);
    }
    return newGrid;
  }

  void printGrid(List<List<Day14State>> grid) {
    print('');
    for (final line in grid) {
      for (final s in line) {
        stdout.write(s.symbol);
      }
      print('');
    }
    print('');
  }

  List<List<Day14State>> parseInput(List<String> lines) {
    List<List<Day14State>> grid = [];
    for (final line in lines) {
      List<Day14State> row = [];
      for (final c in line.split('')) {
        row.add(c == 'O' ? Day14State.roundedRock : c == '#' ? Day14State.cubeShapedRock : Day14State.emptySpace);
      }
      grid.add(row);
    }
    return grid;
  }
}
