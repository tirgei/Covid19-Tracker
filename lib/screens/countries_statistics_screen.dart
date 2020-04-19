import 'package:covid19/data/models/statistic.dart';
import 'package:covid19/utils/constants.dart';
import 'package:covid19/utils/scroll_behaviour.dart';
import 'package:covid19/widgets/color_key.dart';
import 'package:covid19/widgets/statistic_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountriesStatisticsScreen extends StatefulWidget {
  @override
  _CountriesStatisticsScreenState createState() => _CountriesStatisticsScreenState();
}

class _CountriesStatisticsScreenState extends State<CountriesStatisticsScreen> {
  List<Statistic> statistics = List();

  @override
  void initState() {
    super.initState();

    statistics = List.generate(10, (index) =>
      Statistic.country(
        flagUrl: 'https://raw.githubusercontent.com/NovelCOVID/API/master/assets/flags/af.png',
        countryName: 'Afghanistan',
        active: 791,
        recovered: 112,
        dead: 30
      )
    );

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Countries',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                  color: Colors.grey[800]
                ),
              ),
              Icon(
                Icons.search,
                color: Colors.grey[400],
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ColorKey(
                color: Constants.ACTIVE_COLOR_CODE,
                value: 'Active'
              ),
              SizedBox(width: 15),
              ColorKey(
                color: Constants.RECOVERED_COLOR_CODE,
                value: 'Recovered'
              ),
              SizedBox(width: 15),
              ColorKey(
                color: Constants.DEAD_COLOR_CODE,
                value: 'Dead'
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: ScrollConfiguration(
              behavior: CustomScrollBehaviour(),
              child: ListView.separated(
                itemCount: statistics.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemBuilder: (context, index) {
                  return StatisticCard(
                    statistic: statistics[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
