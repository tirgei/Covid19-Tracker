import 'dart:convert';

/// Data class to hold statistics
class Statistic {
  String flagUrl;
  String countryName;
  int active;
  int recovered;
  int dead;
  int updated;
  int cases;

  /// Country statistics constructor
  Statistic.country({this.flagUrl, this.countryName, this.active, this.recovered, this.dead});

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
  static Statistic fromCountryJson(String data) {
    Map<String, dynamic> countryStat = jsonDecode(data);
    Map<String, dynamic> countryInfo = jsonDecode(countryStat['countryInfo']);

    return Statistic.country(
      flagUrl: countryInfo['flag'],
      countryName: countryStat['country'],
      active: countryStat['active'],
      recovered: countryStat['recovered'],
      dead: countryStat['deaths']
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
      updated: stat['updated'] * 1000
    );
  }

}