class Pair<T, U> {
  T left;
  U right;

  Pair(this.left, this.right);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pair &&
          runtimeType == other.runtimeType &&
          left == other.left &&
          right == other.right;

  @override
  int get hashCode => left.hashCode ^ right.hashCode;

  @override
  String toString() {
    return 'Pair{left: $left, right: $right}';
  }
}

class Triple<T, U, V> {
  T left;
  U middle;
  V right;

  Triple(this.left, this.middle, this.right);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Triple &&
          runtimeType == other.runtimeType &&
          left == other.left &&
          middle == other.middle &&
          right == other.right;

  @override
  int get hashCode => left.hashCode ^ middle.hashCode ^ right.hashCode;

  @override
  String toString() {
    return 'Triple{left: $left, middle: $middle, right: $right}';
  }
}