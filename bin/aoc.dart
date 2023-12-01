import 'dart:io';

import 'package:advent_of_code_2023/challenges.dart' as challenges;
import 'package:args/args.dart';

const yearOption = 'year';
const dayOption = 'day';

void main(List<String> arguments) {

  final parser = ArgParser()
  ..addOption(yearOption, mandatory: true, abbr: 'y')
  ..addOption(dayOption, mandatory: true, abbr: 'd');

  ArgResults argResults = parser.parse(arguments);
  final year = asInt(argResults[yearOption]);
  final day = asInt(argResults[dayOption]);

  var lines = readFile(year, day);

  final challenge = challenges.getChallenge(year, day);
  print(challenge.partOne(lines));
  print(challenge.partTwo(lines));
}

List<String> readFile(int year, int day) {

  final fileName = 'input/$year-${day.toString().padLeft(2, '0')}.txt';
  final file = File(fileName);

  List<String> lines;
  try {
    lines = file.readAsLinesSync();
  } catch (e) {

    // Get from web
    lines = <String>[];

  }

  return lines;
}

int asInt(String value) {

  int? intValue = int.tryParse(value);

  if (intValue == null) {
    throw Exception('not an int');
  }

  return intValue;
}