import 'dart:convert';

class Statistic {
  String flagUrl;
  String countryName;
  int active;
  int recovered;
  int dead;

  Statistic({this.flagUrl, this.countryName, this.active, this.recovered, this.dead});

  Statistic.fromJson(String data) {
    Map<String, dynamic> countryStat = jsonDecode(data);
    Map<String, dynamic> countryInfo = jsonDecode(countryStat['countryInfo']);

    Statistic(
      flagUrl: countryInfo['flag'],
      countryName: countryStat['country'],
      active: countryStat['active'],
      recovered: countryStat['recovered'],
      dead: countryStat['deaths']
    );
  }

}