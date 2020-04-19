import 'package:covid19/data/models/statistic.dart';
import 'package:covid19/data/network/api_client.dart';
import 'package:covid19/utils/constants.dart';
import 'package:covid19/utils/scroll_behaviour.dart';
import 'package:covid19/widgets/color_key.dart';
import 'package:covid19/widgets/empty_state.dart';
import 'package:covid19/widgets/loader.dart';
import 'package:covid19/widgets/statistic_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountriesStatisticsScreen extends StatefulWidget {
  @override
  _CountriesStatisticsScreenState createState() => _CountriesStatisticsScreenState();
}

enum SortList {
  alphabetical,
  activeCases,
  recoveredCases,
  deadCases
}

class _CountriesStatisticsScreenState extends State<CountriesStatisticsScreen> {
  ApiClient _apiClient;
  SortList _sortList;

  @override
  void initState() {
    super.initState();
    _apiClient = ApiClient();
    _sortList = SortList.activeCases;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Statistic>>(
      future: _apiClient.getCountries(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.waiting:
            return CountriesStatisticsRoot(
              child: Loader(),
            );

          case ConnectionState.done:
            if (snapshot.hasError || !snapshot.hasData) {
              return emptyState();
            } else {
              return showData(context, snapshot.data, _sortList);
            }
            break;

          case ConnectionState.none:
            return emptyState();
        }

        return emptyState();
      },
    );
  }

  // Empty state widget
  Widget emptyState() {
    return CountriesStatisticsRoot(
      child: EmptyState(),
    );
  }

  // Data widget
  Widget showData(BuildContext context, List<Statistic> statistics, SortList sortList) {
    print('Sorting by: $sortList');

    // Sort list first
    switch(sortList) {
      case SortList.alphabetical:
        statistics.sort((a, b) => a.countryName.toLowerCase().compareTo(b.countryName.toLowerCase()));
        break;

      case SortList.activeCases:
        statistics.sort((a, b) => b.active.compareTo(a.active));
        break;

      case SortList.recoveredCases:
        statistics.sort((a, b) => b.recovered.compareTo(a.recovered));
        break;

      case SortList.deadCases:
        statistics.sort((a,b) => b.dead.compareTo(a.dead));
        break;
    }

    return CountriesStatisticsRoot(
      child: Expanded(
        child: ScrollConfiguration(
          behavior: CustomScrollBehaviour(),
          child: ListView.separated(
            itemCount: statistics.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            separatorBuilder: (context, index) => SizedBox(height: 5),
            itemBuilder: (context, index) {
              return StatisticCard(
                statistic: statistics[index],
              );
            },
          ),
        ),
      ),
      sortList: () { sortListDialog(context); },
    );
  }

  /// Dialog to select style to sort list by
  void sortListDialog(BuildContext context) {
    TextStyle checklistStyle = TextStyle(
      fontSize: 15,
      color: Colors.grey[600],
      letterSpacing: 1
    );

    Widget dialog = SimpleDialog(
      title: Text(
        'Sort Countries List',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          letterSpacing: 1.0,
          color: Colors.grey[800]
        ),
      ),
      children: <Widget>[
        CheckboxListTile(
          title: Text(
            'Alphabetical',
            style: checklistStyle,
          ),
          value: _sortList == SortList.alphabetical,
          onChanged: (value) {
            if (value) {
              setState(() {
                _sortList = SortList.alphabetical;
              });
            }
            Navigator.pop(context); // Close dialog
          },
        ),
        CheckboxListTile(
          title: Text(
            'Active cases',
            style: checklistStyle,
          ),
          value: _sortList == SortList.activeCases,
          onChanged: (value) {
            if (value) {
              setState(() {
                _sortList = SortList.activeCases;
              });
            }
            Navigator.pop(context); // Close dialog
          },
        ),
        CheckboxListTile(
          title: Text(
            'Recovered cases',
            style: checklistStyle,
          ),
          value: _sortList == SortList.recoveredCases,
          onChanged: (value) {
            if (value) {
              setState(() {
                _sortList = SortList.recoveredCases;
              });
            }
            Navigator.pop(context); // Close dialog
          },
        ),
        CheckboxListTile(
          title: Text(
            'Dead cases',
            style: checklistStyle,
          ),
          value: _sortList == SortList.deadCases,
          onChanged: (value) {
            if (value) {
              setState(() {
                _sortList = SortList.deadCases;
              });
            }
            Navigator.pop(context); // Close dialog
          },
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return dialog;
      },
    );
  }
}

/// Root layout for countries statistics screen
class CountriesStatisticsRoot extends StatelessWidget {
  final Widget child;
  final Function sortList;

  CountriesStatisticsRoot({this.child, this.sortList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Countries',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                  color: Colors.grey[800]
                ),
              ),
              GestureDetector(
                child: Icon(
                  Icons.filter_list,
                  color: Colors.grey[500],
                ),
                onTap: () {
                  sortList();
                },
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ColorKey(
                color: Constants.ACTIVE_COLOR_CODE,
                value: 'Active'
              ),
              SizedBox(width: 15),
              ColorKey(
                color: Constants.RECOVERED_COLOR_CODE,
                value: 'Recovered'
              ),
              SizedBox(width: 15),
              ColorKey(
                color: Constants.DEAD_COLOR_CODE,
                value: 'Dead'
              ),
            ],
          ),
          SizedBox(height: 10),
          child
        ],
      ),
    );
  }
}

