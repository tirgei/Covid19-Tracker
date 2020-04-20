import 'package:covid19/data/models/statistic.dart';
import 'package:covid19/utils/utils.dart';
import 'package:flutter/material.dart';

/// Dialog to display more information about country statistics
class StatisticsMoreInfo {

  StatisticsMoreInfo(BuildContext context, Statistic statistic) {
    Widget dialog = SimpleDialog(
      backgroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              statistic.countryInfo.flagUrl,
              height: 25,
              width: 40,
            ),
            SizedBox(width: 5),
            Text(
              statistic.countryName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                letterSpacing: 1.0,
                color: Colors.grey[800]
              ),
            )
          ],
        ),
      ),
      children: <Widget>[
        SizedBox(height: 10),
        MoreInfoItem(
          icon: 'virus.png',
          title: 'Cases',
          value: Utils.commaSeparated(statistic.cases),
        ),
        MoreInfoItem(
          icon: 'cough.png',
          title: 'Active',
          value: Utils.commaSeparated(statistic.active),
        ),
        MoreInfoItem(
          icon: 'patient.png',
          title: 'Recovered',
          value: Utils.commaSeparated(statistic.recovered),
        ),
        MoreInfoItem(
          icon: 'death.png',
          title: 'Dead',
          value: Utils.commaSeparated(statistic.dead),
        ),
      ],
    );

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      }
    );
  }

}

class MoreInfoItem extends StatelessWidget {
  final String icon;
  final String title;
  final String value;

  MoreInfoItem({this.icon, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/$icon',
            height: 30,
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  letterSpacing: 1.0,
                  color: Colors.grey[800]
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
