import 'dart:convert';

import 'package:covid19/data/models/country_info.dart';

/// Data class to hold statistics
class Statistic {
  CountryInfo countryInfo;
  String countryName;
  int active;
  int recovered;
  int dead;
  int updated;
  int cases;

  /// Country statistics constructor
  Statistic.country({this.countryInfo, this.countryName, this.active, this.recovered, this.dead, this.cases, this.updated});

  /// General statistics constructor
  Statistic.summary({this.cases, this.active, this.recovered, this.dead, this.updated});

  /// Get active cases percentage
  double getActivePercent() {
    return ((active/cases) * 100);
  }

  /// Get recovered cases percentage
  double getRecoveredPercent() {
    return ((recovered/cases) * 100);
  }

  /// Get deaths cases percentage
  double getDeathsPercent() {
    return ((dead/cases) * 100);
  }

  /// Parse JSON data to country statistic
  static Statistic fromCountryJson(Map<String, dynamic> countryStat) {

    return Statistic.country(
      countryInfo: CountryInfo.fromJson(countryStat['countryInfo']),
      countryName: countryStat['country'],
      active: countryStat['active'],
      recovered: countryStat['recovered'],
      dead: countryStat['deaths'],
      cases: countryStat['cases'],
      updated: countryStat['updated'] * 1000
    );
  }

  /// Parse JSON to summary statistic
  static Statistic fromSummaryJson(String data) {
    Map<String, dynamic> stat = jsonDecode(data);

    return Statistic.summary(
      cases: stat['cases'],
      active: stat['active'],
      recovered: stat['recovered'],
      dead: stat['deaths'],
      updated: stat['updated'] * 1000,
    );
  }

}