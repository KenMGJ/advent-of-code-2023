import 'challenges.dart';

class Day04CardInfo {
  int cardNumber;
  Set<int> winning;
  Set<int> card;

  Day04CardInfo(this.cardNumber, this.winning, this.card);

  int matches() {
    int matches = 0;
    for (final v in card) {
      if (winning.contains(v)) {
        matches += 1;
      }
    }
    return matches;
  }

  int value() {

    int matches = this.matches();

    if (matches == 0) {
      return 0;
    }

    var val = 1;
    for (int i = 1; i < matches; i++) {
      val = 2 * val;
    }

    return val;
  }
}

class Challenge2023Day04 implements Challenge {

  @override
  String partOne(List<String> lines) {

    final input = parseInput(lines);

    int sum = 0;
    for (final i in input) {
      // print('${i.cardNumber} ${i.value()}');
      sum += i.value();
    }

    return sum.toString();
  }

  List<Day04CardInfo> parseInput(List<String> lines) {
    List<Day04CardInfo> output = [];

    for (final line in lines) {
      final regexp = RegExp(r'^Card *(\d+): (.*) \| (.*)');
      final matches = regexp.firstMatch(line);

      final cardNumber = int.tryParse(matches!.group(1)!)!;
      // print('Card number: $cardNumber');

      final winningString = matches.group(2)!;
      final regexpNumbers = RegExp(r'(\d+)');
      final winningMatches = regexpNumbers.allMatches(winningString);

      Set<int> winning = {};
      for (final m in winningMatches) {
        winning.add(int.tryParse(m.group(1)!)!);
      }


      final cardString = matches.group(3)!;
      final cardMatches = regexpNumbers.allMatches(cardString);

      Set<int> card = {};
      for (final m in cardMatches) {
        card.add(int.tryParse(m.group(1)!)!);
      }

      output.add(Day04CardInfo(cardNumber, winning, card));
    }

    return output;
  }

  @override
  String partTwo(List<String> lines) {

    final input = parseInput(lines);

    Map<int, int> cardCounts = {};
    for (final c in input) {
      cardCounts[c.cardNumber] = 1;
    }

    for (final c in input) {
      final matches = c.matches();
      final cardCount = cardCounts[c.cardNumber]!;

      for (int j = 0; j < cardCount; j++) {
        for (int i = 1; i <= matches; i++) {
          cardCounts[c.cardNumber + i] = cardCounts[c.cardNumber + i]! + 1;
        }
      }
    }

    int sum = 0;
    for (final c in cardCounts.values) {
      sum += c;
    }

    return sum.toString();
  }
}