import 'dart:io';

import 'package:advent_of_code_2023/challenges.dart' as challenges;
import 'package:args/args.dart';

const yearOption = 'year';
const dayOption = 'day';
const suffixOption = 'suffix';

void main(List<String> arguments) {

  final parser = ArgParser()
  ..addOption(yearOption, mandatory: true, abbr: 'y')
  ..addOption(dayOption, mandatory: true, abbr: 'd')
  ..addOption(suffixOption, mandatory: false, abbr: 's');

  ArgResults argResults = parser.parse(arguments);
  final year = asInt(argResults[yearOption]);
  final day = asInt(argResults[dayOption]);
  String suffix = '';
  if (argResults[suffixOption] != null) {
    suffix = '-${argResults[suffixOption]}';
  }

  var lines = readFile(year, day, suffix);

  final challenge = challenges.getChallenge(year, day);
  print(challenge.partOne(List<String>.from(lines)));
  print(challenge.partTwo(List<String>.from(lines)));
}

List<String> readFile(int year, int day, String suffix) {

  final fileName = 'input/$year-${day.toString().padLeft(2, '0')}$suffix.txt';
  final file = File(fileName);

  List<String> lines = file.readAsLinesSync();

  return lines;
}

int asInt(String value) {

  int? intValue = int.tryParse(value);

  if (intValue == null) {
    throw Exception('not an int');
  }

  return intValue;
}