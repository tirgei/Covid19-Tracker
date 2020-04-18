import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  final Widget child;

  DataCard({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      shadowColor: Colors.grey[100],
      elevation: 0.4,
      child: child
    );
  }
}
