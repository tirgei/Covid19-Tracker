import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Image.asset(
              'assets/images/error.png',
              height: 120,
            ),
            SizedBox(height: 30),
            Text(
              'Ooops...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 1.0,
                color: Colors.grey[800]
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Error fetching statistics ',
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1,
                color: Colors.grey[500]
              ),
            ),
            Spacer()
          ],
        )
      ),
    );
  }
}
