import 'package:covid19/data/models/statistic.dart';
import 'package:covid19/utils/constants.dart';
import 'package:covid19/utils/utils.dart';
import 'package:covid19/widgets/color_key.dart';
import 'package:covid19/widgets/data_card.dart';
import 'package:covid19/widgets/dialog_more_info.dart';
import 'package:flutter/material.dart';

class StatisticCard extends StatelessWidget {
  final Statistic statistic;

  StatisticCard({this.statistic});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: DataCard(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.network(
                      statistic.countryInfo.flagUrl,
                      height: 25,
                      width: 40,
                    ),
                    SizedBox(height: 10),
                    Text(
                      statistic.countryName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        letterSpacing: 1.0,
                        color: Colors.grey[800]
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    ColorKey(
                      color: Constants.ACTIVE_COLOR_CODE,
                      value: Utils.commaSeparated(statistic.active),
                    ),
                    ColorKey(
                      color: Constants.RECOVERED_COLOR_CODE,
                      value: Utils.commaSeparated(statistic.recovered),
                    ),
                    ColorKey(
                      color: Constants.DEAD_COLOR_CODE,
                      value: Utils.commaSeparated(statistic.dead),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        StatisticsMoreInfo(context, statistic);
      },
    );
  }
}
