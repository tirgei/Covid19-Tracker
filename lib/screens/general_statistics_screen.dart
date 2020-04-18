import 'package:covid19/utils/constants.dart';
import 'package:covid19/utils/scroll_behaviour.dart';
import 'package:covid19/widgets/dashboard_card.dart';
import 'package:covid19/widgets/data_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class GeneralStatisticsScreen extends StatefulWidget {
  @override
  _GeneralStatisticsScreenState createState() => _GeneralStatisticsScreenState();
}

class _GeneralStatisticsScreenState extends State<GeneralStatisticsScreen> {
  Map<String, double> data = Map();
  List<Color> chartColorList = List();

  @override
  void initState() {
    super.initState();
    data.putIfAbsent("Active", () => 50);
    data.putIfAbsent("Recovered", () => 20);
    data.putIfAbsent("Dead", () => 30);

    // Set chart colors
    chartColorList.add(Constants.ACTIVE_COLOR_CODE);
    chartColorList.add(Constants.RECOVERED_COLOR_CODE);
    chartColorList.add(Constants.DEAD_COLOR_CODE);
  }

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
                    Icon(
                      Icons.settings,
                      color: Colors.grey[400],
                    )
                  ],
                ),
                SizedBox(height: 20.0),
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
                          colorList: chartColorList,
                          chartRadius: 100.0,
                          legendStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                          chartValueStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold
                          )
                        ),
                        SizedBox(height: 15.0),
                        Align(
                          child: Text(
                            'Last updated: 23.04.2020',
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
                      statistic: 21424233.toString(),
                      title: 'Cases',
                    ),
                    SizedBox(width: 10.0),
                    DashboardCard(
                      icon: 'death.png',
                      statistic: 233.toString(),
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
                      statistic: 23.toString(),
                      title: 'Recovered',
                    ),
                    SizedBox(width: 10.0),
                    DashboardCard(
                      icon: 'cough.png',
                      statistic: 21423.toString(),
                      title: 'Active',
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
