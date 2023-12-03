
import 'dart:math';

extension ManhattanDistance<T extends num> on Point<T> {

  T manhattanDistanceTo(Point<T> other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return dx.abs() + dy.abs() as T;
  }
}

class Point3D<T extends num> {
  final T x;
  final T y;
  final T z;

  const Point3D(this.x, this.y, this.z);

  @override
  String toString() => 'Point3D($x, $y, $z)';

  @override
  bool operator ==(Object other) =>
      other is Point3D && x == other.x && y == other.y && z == other.z;

  @override
  int get hashCode => Object.hash(x.hashCode, y.hashCode, z.hashCode);

  Point3D<T> operator +(Point3D<T> other) {
    return Point3D<T>((x + other.x) as T, (y + other.y) as T, (z + other.z) as T);
  }

  Point3D<T> operator -(Point3D<T> other) {
    return Point3D<T>((x - other.x) as T, (y - other.y) as T, (z - other.z) as T);
  }

  Point3D<T> operator *(num /*T|int*/ factor) {
    return Point3D<T>((x * factor) as T, (y * factor) as T, (z * factor) as T);
  }

  double get magnitude => sqrt(x * x + y * y + z * z);

  double distanceTo(Point3D<T> other) {
    var dx = x - other.x;
    var dy = y - other.y;
    var dz = z - other.z;
    return sqrt(dx * dx + dy * dy + dz * dz);
  }

  T squaredDistanceTo(Point3D<T> other) {
    var dx = x - other.x;
    var dy = y - other.y;
    var dz = z - other.z;
    return (dx * dx + dy * dy + dz * dz) as T;
  }

  T manhattanDistanceTo(Point3D<T> other) {
    var dx = x - other.x;
    var dy = y - other.y;
    var dz = z - other.z;
    return dx.abs() + dy.abs() + dz.abs() as T;
  }
}
