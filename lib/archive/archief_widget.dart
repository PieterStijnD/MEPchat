import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

import 'menu_archive_widget.dart';
import 'mep_list_archive_widget.dart';
import 'recipe_archive_widget.dart';

class ArchiefWidget extends StatefulWidget {
  const ArchiefWidget({Key? key}) : super(key: key);

  @override
  State<ArchiefWidget> createState() => _ArchiefWidgetState();
}

class _ArchiefWidgetState extends State<ArchiefWidget> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MepListArchiveWidget(),
    MenuArchiveWidget(),
    RecipeArchiveWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            DelayedDisplay(
              delay: Duration(milliseconds: 200),
              child: FloatingActionButton.extended(
                backgroundColor:
                    _selectedIndex == 0 ? Colors.blue : Colors.grey,
                onPressed: () {
                  _onItemTapped(0);
                },
                label: const Text('MEP-lijsten'),
              ),
            ),
            DelayedDisplay(
              delay: Duration(milliseconds: 300),
              child: FloatingActionButton.extended(
                backgroundColor:
                    _selectedIndex == 1 ? Colors.blue : Colors.grey,
                onPressed: () {
                  _onItemTapped(1);
                },
                label: const Text('Menukaarten'),
              ),
            ),
            DelayedDisplay(
              delay: Duration(milliseconds: 400),
              child: FloatingActionButton.extended(
                backgroundColor:
                    _selectedIndex == 2 ? Colors.blue : Colors.grey,
                onPressed: () {
                  _onItemTapped(2);
                },
                label: const Text('Recepten'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
