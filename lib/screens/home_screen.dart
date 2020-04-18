import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:covid19/screens/countries_statistics_screen.dart';
import 'package:covid19/screens/general_statistics_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: <Widget>[
              GeneralStatisticsScreen(),
              CountriesStatisticsScreen()
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentPage,
        onItemSelected: (index) {
          setState(() {
            _currentPage = index;
          });
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text('World'),
            icon: Icon(Icons.home),
          ),
          BottomNavyBarItem(
            title: Text('Countries'),
            icon: Icon(Icons.list)
          )
        ],
        showElevation: false,
        backgroundColor: Colors.white,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }
}
