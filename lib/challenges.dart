import '202201.dart';
import '202202.dart';
import '202301.dart';
import '202302.dart';
import '202303.dart';
import '202304.dart';
import '202305.dart';
import '202306.dart';
import '202307.dart';
import '202308.dart';
import '202309.dart';
import '202310.dart';
import '202311.dart';
import '202312.dart';
import '202313.dart';
import '202314.dart';
import '202315.dart';
import '202316.dart';
import '202317.dart';

abstract class Challenge {
  String partOne(List<String> lines);
  String partTwo(List<String> lines);
}

Challenge getChallenge(int year, int day) {

  if (year == 2022 && day == 1) {
    return Challenge2022Day01();
  } else if (year == 2022 && day == 2) {
    return Challenge2022Day02();
  } else if (year == 2023 && day == 1) {
    return Challenge2023Day01();
  } else if (year == 2023 && day == 2) {
    return Challenge2023Day02();
  } else if (year == 2023 && day == 3) {
    return Challenge2023Day03();
  } else if (year == 2023 && day == 4) {
    return Challenge2023Day04();
  } else if (year == 2023 && day == 5) {
    return Challenge2023Day05();
  } else if (year == 2023 && day == 6) {
    return Challenge2023Day06();
  } else if (year == 2023 && day == 7) {
    return Challenge2023Day07();
  } else if (year == 2023 && day == 8) {
    return Challenge2023Day08();
  } else if (year == 2023 && day == 9) {
    return Challenge2023Day09();
  } else if (year == 2023 && day == 10) {
    return Challenge2023Day10();
  } else if (year == 2023 && day == 11) {
    return Challenge2023Day11();
  } else if (year == 2023 && day == 12) {
    return Challenge2023Day12();
  } else if (year == 2023 && day == 13) {
    return Challenge2023Day13();
  } else if (year == 2023 && day == 14) {
    return Challenge2023Day14();
  } else if (year == 2023 && day == 15) {
    return Challenge2023Day15();
  } else if (year == 2023 && day == 16) {
    return Challenge2023Day16();
  } else if (year == 2023 && day == 17) {
    return Challenge2023Day17();
  } else {
    return ChallengeUnimplemented();
  }
}

class ChallengeUnimplemented implements Challenge {

  @override
  String partOne(List<String> lines) {
    return 'unimplemented';
  }

  @override
  String partTwo(List<String> lines) {
    return 'unimplemented';
  }
}



