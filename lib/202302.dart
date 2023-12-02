import 'challenges.dart';

const marbles = {'red': 12, 'green': 13, 'blue': 14, };

class Challenge2023Day02 implements Challenge {

  @override
  String partOne(List<String> lines) {

    int sum = 0;

    for (final line in lines) {
      final regexp = RegExp(r'^Game (\d+): (.*)$');
      final match = regexp.firstMatch(line);

      int game = 0;

      if (match != null) {
        game = int.tryParse(match.group(1) ?? '0') ?? 0;
        final draws = match.group(2) ?? '';

        for (final d in draws.split('; ')) {
          for (final m in d.split(', ')) {

            final reg = RegExp(r'^(\d+) (.*)$');
            final mch = reg.firstMatch(m);

            if (mch != null) {
              final n = int.tryParse(mch.group(1) ?? '0') ?? 0;
              final k = mch.group(2) ?? '';

              if (n > (marbles[k] ?? 0)) {
                game = 0;
              }
            }

            if (game == 0) {
              break;
            }
          }

          if (game == 0) {
            break;
          }
        }
      }

      sum += game;
    }

    return sum.toString();
  }

  @override
  String partTwo(List<String> lines) {

    int sum = 0;

    for (final line in lines) {
      final regexp = RegExp(r'^Game \d+: (.*)$');
      final match = regexp.firstMatch(line);

      var lowest = <String, int>{};

      if (match != null) {
        final draws = match.group(1) ?? '';

        for (final d in draws.split('; ')) {
          for (final m in d.split(', ')) {

            final reg = RegExp(r'^(\d+) (.*)$');
            final mch = reg.firstMatch(m);

            if (mch != null) {
              final n = int.tryParse(mch.group(1)!)!;
              final k = mch.group(2) ?? '';

              if (!lowest.containsKey(k) || lowest[k]! < n) {
                lowest[k] = n;
              }
            }
          }
        }
      }

      int power = 1;
      lowest.forEach((key, value) { power *= value; });

      sum += power;
    }

    return sum.toString();
  }

}