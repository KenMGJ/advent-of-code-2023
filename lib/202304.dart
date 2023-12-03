import 'dart:math';

import 'challenges.dart';
import 'point3d.dart';

class Challenge2023Day04 implements Challenge {

  @override
  String partOne(List<String> lines) {

    const pointA = Point<int>(1, 3);
    const pointB = Point<int>(5, 12);

    print(pointA.distanceTo(pointB));
    print(pointA.manhattanDistanceTo(pointB));

    const pointA3 = Point3D<int>(1, 3, 0);
    const pointB3 = Point3D<int>(5, 12, 0);

    print(pointA3.distanceTo(pointB3));
    print(pointA3.manhattanDistanceTo(pointB3));

    return '1';
  }

  @override
  String partTwo(List<String> lines) {
    return '2';
  }
}