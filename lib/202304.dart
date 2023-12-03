import 'dart:math';

import 'challenges.dart';

class Challenge2023Day04 implements Challenge {

  @override
  String partOne(List<String> lines) {

    const pointA = Point<int>(1, 3);
    const pointB = Point<int>(5, 12);

    print(pointA.distanceTo(pointB));

    return '1';
  }

  @override
  String partTwo(List<String> lines) {
    return '2';
  }
}