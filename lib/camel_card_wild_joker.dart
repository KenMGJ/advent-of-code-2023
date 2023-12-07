import 'camel_card.dart';

enum CamelCardWildJoker implements Comparable<CamelCardWildJoker> {
  cJ(order: 1),
  c2(order: 2),
  c3(order: 3),
  c4(order: 4),
  c5(order: 5),
  c6(order: 6),
  c7(order: 7),
  c8(order: 8),
  c9(order: 9),
  cT(order: 10),
  cQ(order: 11),
  cK(order: 12),
  cA(order: 13);

  const CamelCardWildJoker({
    required this.order,
  });

  final int order;

  @override
  int compareTo(CamelCardWildJoker other) => order.compareTo(other.order);
}

class CamelHandWildJoker implements Comparable<CamelHandWildJoker> {
  List<CamelCardWildJoker> cards;
  int bid;

  CamelHandType? _type;

  CamelHandWildJoker(this.cards, this.bid);

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
  int compareTo(CamelHandWildJoker other) {
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

    int joker = 0;
    final countPerCard = <CamelCardWildJoker, int>{};
    for (final card in cards) {
      if (card == CamelCardWildJoker.cJ) {
        joker += 1;
      } else {
        countPerCard[card] = (countPerCard[card] ?? 0) + 1;
      }
    }

    _type = CamelHandType.highCard;
    if (joker > 0) {
      for (final v in CamelCardWildJoker.values.reversed) {
        final newList = cards.map((e) => e == CamelCardWildJoker.cJ ? v : e).toList();
        final type = getType(newList);
        if (type.compareTo(_type!) > 0) {
          _type = type;
        }
      }
    } else {
      _type = getType(cards);
    }

    return _type!;
  }

  CamelHandType getType(List<CamelCardWildJoker> cards) {

    final countPerCard = <CamelCardWildJoker, int>{};
    for (final card in cards) {
      countPerCard[card] = (countPerCard[card] ?? 0) + 1;
    }

    final cardCount = <int, int>{};
    for (final c in countPerCard.values) {
      cardCount[c] = (cardCount[c] ?? 0) + 1;
    }

    CamelHandType? type;

    switch (countPerCard.length) {
      case 1:
        type = CamelHandType.fiveOfAKind;
        break;
      case 2:
        if (cardCount.containsKey(3)) {
          type = CamelHandType.fullHouse;
        } else {
          type = CamelHandType.fourOfAKind;
        }
        break;
      case 3:
        if (cardCount.containsKey(2)) {   // 2a 2b 1c
          type = CamelHandType.twoPair;
        } else if (cardCount.containsKey(3)) { // 3a 1b 1b
          type = CamelHandType.threeOfAKind;
        }
        break;
      case 4:
        type = CamelHandType.onePair;
        break;
      case 5:
        type = CamelHandType.highCard; // 1 2 3 4 5
    }

    return type!;
  }
}