import 'package:flutter/material.dart';

import 'package:leetrack/views/StatsPage.dart';

class ScaffoldBase extends StatefulWidget {
  final String? title;
  final List<Widget>? child;
  final double? childPadding;
  const ScaffoldBase(
      {Key? key,
      @required this.title,
      @required this.child,
      //make default 8
      @required this.childPadding})
      : super(key: key);

  @override
  State<ScaffoldBase> createState() => _ScaffoldBaseState();
}

class _ScaffoldBaseState extends State<ScaffoldBase> {
  @override
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    StatsPage(),
    Icon(
      Icons.camera,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(widget.title!),
      ),
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
          setState(() => _selectedIndex = value);
        },
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
    );
  }
}
