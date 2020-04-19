/// Data class for Country info
class CountryInfo {
  String flagUrl;

  CountryInfo({this.flagUrl});

  /// Parse Map from JSON data to CountryInfo object
  static CountryInfo fromJson(Map<String, dynamic> data) {
    return CountryInfo(
      flagUrl: data['flag']
    );
  }

}