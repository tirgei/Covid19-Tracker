import 'package:covid19/utils/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
                Constants.APP_NAME,
                style: TextStyle(
                    letterSpacing: 1.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0.0,
        ),
    );
  }
}
