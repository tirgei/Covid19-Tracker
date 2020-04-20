import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Class to hold utility functions
class Utils {

  // Format number to include comma separator for numbers
  static String commaSeparated(int number) {
    return FlutterMoneyFormatter(amount: number.toDouble()).output.withoutFractionDigits;
  }

  // Toast message
  static toast(String message, {Toast length = Toast.LENGTH_LONG}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length
    );
  }

}