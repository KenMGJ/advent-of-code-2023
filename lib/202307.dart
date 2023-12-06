import 'challenges.dart';

class Challenge2023Day07 implements Challenge {

  @override
  String partOne(List<String> lines) {
    return '1';
  }

  @override
  String partTwo(List<String> lines) {
    return '2';
  }


  int calcDistance2(int hold, int total) {
    return -1 * ( (hold * hold) - (hold * total) );
  }
}