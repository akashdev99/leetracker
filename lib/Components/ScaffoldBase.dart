import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class ScaffoldBase extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(title!),
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
        ),
        body: ListView(
            padding: EdgeInsets.all(childPadding!),
            children: <Widget>[...child!]));
  }
}
