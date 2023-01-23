import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

import '../menukaarten_widget.dart';
import '../recepturen_widget.dart';
import 'mep_lijst_widget.dart';

class MepPageWrapperWidget extends StatefulWidget {
  const MepPageWrapperWidget({Key? key}) : super(key: key);

  @override
  State<MepPageWrapperWidget> createState() => _MepPageWrapperWidgetState();
}

class _MepPageWrapperWidgetState extends State<MepPageWrapperWidget> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MepLijstWidget(),
    MenuKaartenWidget(),
    RecipesWidget(),
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
                onPressed: () {
                  _onItemTapped(0);
                },
                label: const Text('MEP-lijsten'),
              ),
            ),
            DelayedDisplay(
              delay: Duration(milliseconds: 300),
              child: FloatingActionButton.extended(
                onPressed: () {
                  _onItemTapped(1);
                },
                label: const Text('Menukaarten'),
              ),
            ),
            DelayedDisplay(
              delay: Duration(milliseconds: 400),
              child: FloatingActionButton.extended(
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
