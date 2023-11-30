import 'package:advent_of_code_2023/advent_of_code_2023.dart' as advent_of_code_2023;
import 'package:args/args.dart';

const year_option = 'year';
const day_option = 'day';

void main(List<String> arguments) {

  final parser = ArgParser()
  ..addOption(year_option, mandatory: true, abbr: 'y')
  ..addOption(day_option, mandatory: true, abbr: 'd');

  ArgResults argResults = parser.parse(arguments);
  final year = asInt(argResults[year_option]);
  final day = asInt(argResults[day_option]);

  print('${year}-${day}');

  final challenge = advent_of_code_2023.getChallenge(year, day);
  print('${challenge.partOne()}');
  print('${challenge.partTwo()}');
}

int asInt(String value) {

  int? intValue = int.tryParse(value);

  if (intValue == null) {
    print('do something');
    return 0;
  }

  return intValue;
}