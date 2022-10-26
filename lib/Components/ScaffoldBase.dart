import 'package:flutter/material.dart';

import 'package:leetrack/views/StatsPage.dart';
import 'package:leetrack/views/SettingsPage.dart';
import 'package:leetrack/views/GoalsPage.dart';

class ScaffoldBase extends StatefulWidget {
  const ScaffoldBase({
    Key? key,
  }) : super(key: key);

  @override
  State<ScaffoldBase> createState() => _ScaffoldBaseState();
}

class _ScaffoldBaseState extends State<ScaffoldBase> {
  @override
  int _selectedIndex = 0;
  String _title = "Statistics";

  static List<Widget> _pages = <Widget>[
    StatsPage(),
    GoalsPage(),
    SettingsPage(),
  ];

  static List<String> _pageTitle = <String>["Statistics", "Goals", "Settings"];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          title: Text(_title, style: Theme.of(context).textTheme.headline1),
          centerTitle: false,
          backgroundColor: Theme.of(context).backgroundColor,
          foregroundColor: Colors.black,
          elevation: 0),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.query_stats),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Goals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (value) {
          // Respond to item press.
          setState(() => {_selectedIndex = value, _title = _pageTitle[value]});
        },
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
    );
  }
}
