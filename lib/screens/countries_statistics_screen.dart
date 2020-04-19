import 'package:covid19/data/models/statistic.dart';
import 'package:covid19/data/network/api_client.dart';
import 'package:covid19/utils/constants.dart';
import 'package:covid19/utils/scroll_behaviour.dart';
import 'package:covid19/widgets/color_key.dart';
import 'package:covid19/widgets/empty_state.dart';
import 'package:covid19/widgets/loader.dart';
import 'package:covid19/widgets/statistic_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountriesStatisticsScreen extends StatefulWidget {
  @override
  _CountriesStatisticsScreenState createState() => _CountriesStatisticsScreenState();
}

class _CountriesStatisticsScreenState extends State<CountriesStatisticsScreen> {
  ApiClient _apiClient;

  @override
  void initState() {
    super.initState();
    _apiClient = ApiClient();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Statistic>>(
      future: _apiClient.getCountries(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.waiting:
            return CountriesStatisticsRoot(
              child: Loader(),
            );

          case ConnectionState.done:
            if (snapshot.hasError || !snapshot.hasData) {
              return emptyState();
            } else {
              return showData(snapshot.data);
            }
            break;

          case ConnectionState.none:
            return emptyState();
        }

        return emptyState();
      },
    );
  }

  // Empty state widget
  Widget emptyState() {
    return CountriesStatisticsRoot(
      child: EmptyState(),
    );
  }

  // Data widget
  Widget showData(List<Statistic> statistics) {
    return CountriesStatisticsRoot(
      child: Expanded(
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
    );
  }
}

/// Root layout for countries statistics screen
class CountriesStatisticsRoot extends StatelessWidget {
  final Widget child;

  CountriesStatisticsRoot({this.child});

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
          child
        ],
      ),
    );
  }
}

