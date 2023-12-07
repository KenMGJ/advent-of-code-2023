enum CamelCard implements Comparable<CamelCard> {
  c2(order: 1),
  c3(order: 2),
  c4(order: 3),
  c5(order: 4),
  c6(order: 5),
  c7(order: 6),
  c8(order: 7),
  c9(order: 8),
  cT(order: 9),
  cJ(order: 10),
  cQ(order: 11),
  cK(order: 12),
  cA(order: 13);

  const CamelCard({
    required this.order,
  });

  final int order;

  @override
  int compareTo(CamelCard other) => order.compareTo(other.order);
}

enum CamelHandType implements Comparable<CamelHandType> {
  highCard(order: 1),
  onePair(order: 2),
  twoPair(order: 3),
  threeOfAKind(order: 4),
  fullHouse(order: 5),
  fourOfAKind(order: 6),
  fiveOfAKind(order: 7);

  const CamelHandType({
    required this.order,
  });

  final int order;

  @override
  int compareTo(CamelHandType other) => order.compareTo(other.order);
}

class CamelHand implements Comparable<CamelHand> {
  List<CamelCard> cards;
  int bid;

  CamelHandType? _type;

  CamelHand(this.cards, this.bid);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CamelHand &&
          runtimeType == other.runtimeType &&
          cards == other.cards &&
          bid == other.bid;

  @override
  int get hashCode => cards.hashCode ^ bid.hashCode;

  @override
  String toString() {
    return 'CamelHand{cards: $cards, bid: $bid}';
  }

  @override
  int compareTo(CamelHand other) {
    final cmp = type.compareTo(other.type);
    if (cmp != 0) {
      return cmp;
    }

    for (int i = 0; i < 5; i++) {
      final a = cards[i];
      final b = other.cards[i];

      final cmp = a.compareTo(b);
      if (cmp != 0) {
        return cmp;
      }
    }

    return 0;
  }

  CamelHandType get type {
    if (_type != null) {
      return _type!;
    }

    final countPerCard = <CamelCard, int>{};
    for (final card in cards) {
      countPerCard[card] = (countPerCard[card] ?? 0) + 1;
    }

    final cardCount = <int, int>{};
    for (final c in countPerCard.values) {
      cardCount[c] = (cardCount[c] ?? 0) + 1;
    }

    switch (countPerCard.length) {
      case 1:
        _type = CamelHandType.fiveOfAKind;
        break;
      case 2:
        if (cardCount.containsKey(3)) {
          _type = CamelHandType.fullHouse;
        } else {
          _type = CamelHandType.fourOfAKind;
        }
        break;
      case 3:
        if (cardCount.containsKey(2)) {   // 2a 2b 1c
          _type = CamelHandType.twoPair;
        } else if (cardCount.containsKey(3)) { // 3a 1b 1b
          _type = CamelHandType.threeOfAKind;
        }
        break;
      case 4:
        _type = CamelHandType.onePair;
        break;
      case 5:
        _type = CamelHandType.highCard; // 1 2 3 4 5
    }

    return _type!;
  }
}