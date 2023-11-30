abstract class Challenge {
  String partOne();
  String partTwo();
}

Challenge getChallenge(int year, int day) {

  if (year == 2023 && day == 1) {
    return Challenge2023Day01();
  } else {
    return ChallengeUnimplemented();
  }

}

class ChallengeUnimplemented implements Challenge {
  
  String partOne() {
    return 'unimplemented';
  }

  String partTwo() {
    return 'unimplemented';
  }
}

class Challenge2023Day01 implements Challenge {

  String partOne() {
    return '1';
  }

  String partTwo() {
    return '2';
  }

}