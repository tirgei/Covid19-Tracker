import 'package:covid19/widgets/data_card.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DashboardCard extends StatelessWidget {
  final String icon;
  final String statistic;
  final String title;
  
  DashboardCard({
    @required this.icon,
    @required this.statistic,
    @required this.title
  });
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: DataCard(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/$icon',
                height: 40,
              ),
              SizedBox(height: 5),
              Text(
                statistic,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  color: Colors.grey[800]
                ),
              ),
              SizedBox(height: 5),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500]
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
