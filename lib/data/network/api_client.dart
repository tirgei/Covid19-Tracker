import 'package:covid19/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:covid19/data/models/statistic.dart';

/// Class to handle HTTP requests
class ApiClient {

  /// Fetch summary statistics
  Future<Statistic> getSummary() async {
    try {
      var response = await http.get(Constants.SUMMARY_URL);
      return Statistic.fromSummaryJson(response.body);
    } catch (e) {
      print('Error fetching summary: $e');
      return e;
    }
  }

  /// Fetch countries statistics
  Future<List<Statistic>> getCountries() async {
    try {
      var response = await http.get(Constants.COUNTRIES_URL);
      List<Map<String, dynamic>> countries = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      return countries.map((country) => Statistic.fromCountryJson(country)).toList();
    } catch (e) {
      print('Error fetching countries statistics: $e');
      return e;
    }
  }

}