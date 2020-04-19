import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Center(
        child: Loading(
          indicator: BallSpinFadeLoaderIndicator(),
          size: 60,
          color: Colors.blue,
        ),
      ),
    );
  }
}
