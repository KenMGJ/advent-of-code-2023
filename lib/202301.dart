import 'challenges.dart';

const Map<String, String> stringToNumberMap = {
  'one': '1', 'two': '2', 'three': '3', 'four': '4', 'five': '5', 'six': '6',
  'seven': '7', 'eight': '8', 'nine': '9',
};

class Challenge2023Day01 implements Challenge {

  @override
  String partOne(List<String> lines) {

    var total = 0;

    for (final l in lines) {
      final tens = findFirst(l);
      final ones = findFirst(l.split('').reversed.join());
      // print('$tens $ones');
      total += (tens * 10) + ones;
    }

    return total.toString();
  }

  @override
  String partTwo(List<String> lines) {

    var total = 0;

    for (final l in lines) {

      final tens = findFirst(findAndReplaceFirst(l));
      final ones = findFirst(findAndReplaceLast(l).split('').reversed.join());

      // print('$tens $ones');
      total += (tens * 10) + ones;
    }

    return total.toString();
  }

  int findFirst(String string) {
    var val = -1;
    for (final s in string.split('')) {
      int v = int.tryParse(s) ?? -1;
      if (v >= 0) {
        val = v;
        break;
      }
    }
    return val;
  }

  String findAndReplaceFirst(String string) {

    String key = '';
    int location = string.length;

    for (final k in stringToNumberMap.keys) {
      final loc = string.indexOf(k);
      if (loc > -1 && loc < location) {
        key = k;
        location = loc;
      }
    }

    String newString = string;
    if (key != '') {
      newString = newString.replaceFirst(key, stringToNumberMap[key] ?? key);
    }

    return newString;
  }

  String findAndReplaceLast(String string) {

    String key = '';
    int location = -1;

    for (final k in stringToNumberMap.keys) {
      final loc = string.lastIndexOf(k);
      if (loc > location) {
        key = k;
        location = loc;
      }
    }

    String newString = string;
    if (key != '') {
      newString = newString.replaceFirst(key, stringToNumberMap[key] ?? key, location);
    }

    return newString;
  }
}