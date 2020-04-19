import 'package:covid19/utils/constants.dart';
import 'package:http/http.dart' as http;

import 'package:covid19/data/models/statistic.dart';

/// Class to handle HTTP requests
class ApiClient {

  /// Fetch summary statistics
  Future<Statistic> getSummary() async {
    var response = await http.get(Constants.SUMMARY_URL);
    print('Summary response: ${response.body}');
    return Statistic.fromSummaryJson(response.body);
  }

}