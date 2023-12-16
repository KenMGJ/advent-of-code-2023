enum Direction {
  up(symbol: '^'),
  right(symbol: '>'),
  down(symbol: 'v'),
  left(symbol: '<');

  const Direction({
    required this.symbol,
  });

  final String symbol;

  Direction turnRight() {
    switch (this) {
      case Direction.up:
        return Direction.right;
      case Direction.right:
        return Direction.down;
      case Direction.down:
        return Direction.left;
      case Direction.left:
        return Direction.up;
    }
  }

  Direction turnLeft() {
    switch (this) {
      case Direction.up:
        return Direction.left;
      case Direction.left:
        return Direction.down;
      case Direction.down:
        return Direction.right;
      case Direction.right:
        return Direction.up;
    }
  }

}