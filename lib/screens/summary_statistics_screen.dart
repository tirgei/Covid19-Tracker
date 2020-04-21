import 'package:connectivity/connectivity.dart';
import 'package:covid19/data/models/statistic.dart';
import 'package:covid19/data/network/api_client.dart';
import 'package:covid19/utils/constants.dart';
import 'package:covid19/utils/scroll_behaviour.dart';
import 'package:covid19/utils/utils.dart';
import 'package:covid19/widgets/dashboard_card.dart';
import 'package:covid19/widgets/data_card.dart';
import 'package:covid19/widgets/empty_state.dart';
import 'package:covid19/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';

class SummaryStatisticsScreen extends StatefulWidget {
  @override
  _SummaryStatisticsScreenState createState() => _SummaryStatisticsScreenState();
}

class _SummaryStatisticsScreenState extends State<SummaryStatisticsScreen> {
  List<Color> _chartColorList;
  ApiClient _apiClient;
  Statistic statistic;

  @override
  void initState() {
    super.initState();
    _apiClient = ApiClient();
    _chartColorList = [Constants.ACTIVE_COLOR_CODE, Constants.RECOVERED_COLOR_CODE, Constants.DEAD_COLOR_CODE];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        print('Snapshot data: ${snapshot.hasData} & data loaded: ${statistic != null}');

        if(!snapshot.hasData && statistic == null) {
          return emptyState();
        }

        switch(snapshot.data) {
          case ConnectivityResult.mobile:
          case ConnectivityResult.wifi:
            if (statistic == null) {
              return loadData();
            } else {
              return showData(statistic);
            }
            break;

          case ConnectivityResult.none:
            if (statistic == null) {
              return emptyState();
            } else {
              return showData(statistic);
            }
            break;
        }

        return emptyState();
      },
    );

  }

  Widget loadData() {
    return FutureBuilder<Statistic>(
      future: _apiClient.getSummary(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.waiting:
            return SummaryStatisticsRoot(
              child: Loader(),
            );

          case ConnectionState.done:
            if (snapshot.hasError || !snapshot.hasData) {
              return emptyState();
            } else {
              statistic = snapshot.data;
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

  // Display empty state
  Widget emptyState() {
    return SummaryStatisticsRoot(
      child: EmptyState(),
    );
  }

  // Display data
  Widget showData(Statistic statistic) {
    Map<String, double> data = Map();

    data.putIfAbsent("Active", () => statistic.getActivePercent());
    data.putIfAbsent("Recovered", () => statistic.getRecoveredPercent());
    data.putIfAbsent("Dead", () => statistic.getDeathsPercent());

    return SummaryStatisticsRoot(
      child: Column(
        children: <Widget>[
          DataCard(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 15),
              child: Column(
                children: <Widget>[
                  PieChart(
                    dataMap: data,
                    chartLegendSpacing: 50.0,
                    legendPosition: LegendPosition.right,
                    chartType: ChartType.ring,
                    showChartValuesOutside: true,
                    colorList: _chartColorList,
                    chartRadius: 100.0,
                    legendStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                    chartValueStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  SizedBox(height: 15.0),
                  Align(
                    child: Text(
                      'Last updated: ${DateFormat.yMMMEd().format(DateTime.fromMicrosecondsSinceEpoch(statistic.updated))}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[400]
                      ),
                    ),
                    alignment: Alignment.bottomRight,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10 ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              DashboardCard(
                icon: 'virus.png',
                statistic: Utils.commaSeparated(statistic.cases),
                title: 'Cases',
              ),
              SizedBox(width: 10.0),
              DashboardCard(
                icon: 'death.png',
                statistic: Utils.commaSeparated(statistic.dead),
                title: 'Dead',
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              DashboardCard(
                icon: 'patient.png',
                statistic: Utils.commaSeparated(statistic.recovered),
                title: 'Recovered',
              ),
              SizedBox(width: 10.0),
              DashboardCard(
                icon: 'cough.png',
                statistic: Utils.commaSeparated(statistic.active),
                title: 'Active',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Root layout for Summary screen
class SummaryStatisticsRoot extends StatelessWidget {
  final Widget child;
  
  SummaryStatisticsRoot({this.child});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: ScrollConfiguration(
        behavior: CustomScrollBehaviour(),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'World Summary',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        letterSpacing: 1.0,
                        color: Colors.grey[800]
                      ),
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.wb_incandescent,
                        color: Colors.grey[500],
                      ),
                      onTap: () {
                        Utils.toast('Dark Theme coming soon!');
                      },
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                child,
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

