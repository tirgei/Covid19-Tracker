import 'package:flutter/material.dart';

/// Widget for displaying color and value combo
/// Color is shown as a dot while value is text
class ColorKey extends StatelessWidget {
  final Color color;
  final String value;

  ColorKey({this.color, this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.all(Radius.circular(50.0))
          ),
        ),
        SizedBox(width: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
            fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }
}
