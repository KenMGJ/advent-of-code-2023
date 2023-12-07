import 'challenges.dart';
import 'camel_card.dart';
import 'camel_card_wild_joker.dart';

class Challenge2023Day07 implements Challenge {

  @override
  String partOne(List<String> lines) {
    final hands = parseInput(lines);
    hands.sort();

    int winnings = 0;
    int i = 1;
    for (final hand in hands) {
      // print(hand);
      // print(hand.type);
      // print('');

      winnings += i * hand.bid;
      i++;
    }

    return winnings.toString();
  }

  @override
  String partTwo(List<String> lines) {
    final hands = parseInputPart2(lines);
    hands.sort();

    int winnings = 0;
    int i = 1;
    for (final hand in hands) {
      // print(hand);
      // print(hand.type);
      // print('');

      winnings += i * hand.bid;
      i++;
    }

    return winnings.toString();
  }

  List<CamelHand> parseInput(List<String> lines) {

    List<CamelHand> hands = [];

    for (final line in lines) {
      final regexp = RegExp(r'(.{5}) (\d+)$');
      final match = regexp.firstMatch(line);
      final labels = match!.group(1)!;
      final bid = int.tryParse(match.group(2)!)!;

      List<CamelCard> cards = [];
      for (final label in labels.split('')) {
        cards.add(toCamelCard(label));
      }

      hands.add(CamelHand(cards, bid));
    }

    return hands;
  }

  List<CamelHandWildJoker> parseInputPart2(List<String> lines) {

    List<CamelHandWildJoker> hands = [];

    for (final line in lines) {
      final regexp = RegExp(r'(.{5}) (\d+)$');
      final match = regexp.firstMatch(line);
      final labels = match!.group(1)!;
      final bid = int.tryParse(match.group(2)!)!;

      List<CamelCardWildJoker> cards = [];
      for (final label in labels.split('')) {
        cards.add(toCamelCardWildJoker(label));
      }

      hands.add(CamelHandWildJoker(cards, bid));
    }

    return hands;
  }

  CamelCard toCamelCard(String label) {
    label = 'c$label';
    return CamelCard.values.firstWhere((e) => e.toString() == 'CamelCard.$label');
  }

  CamelCardWildJoker toCamelCardWildJoker(String label) {
    label = 'c$label';
    return CamelCardWildJoker.values.firstWhere((e) => e.toString() == 'CamelCardWildJoker.$label');
  }
}