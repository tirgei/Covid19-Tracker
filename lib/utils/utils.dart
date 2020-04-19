import 'package:flutter_money_formatter/flutter_money_formatter.dart';

/// Class to hold utility functions
class Utils {

  // Format number to include comma separator for numbers
  static String commaSeparated(int number) {
    return FlutterMoneyFormatter(amount: number.toDouble()).output.withoutFractionDigits;
  }

}