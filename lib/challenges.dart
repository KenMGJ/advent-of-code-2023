import 'package:advent_of_code_2023/202201.dart';
import 'package:advent_of_code_2023/202202.dart';
import 'package:advent_of_code_2023/202301.dart';
import 'package:advent_of_code_2023/202302.dart';

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


