import 'package:flutter/material.dart';
import 'package:new_base/login_page.dart';
import 'package:new_base/meplijst/mep_page_wrapper_widget.dart';
import 'package:new_base/recepturen_widget.dart';
import 'package:new_base/teams_page/teams_page_widget.dart';
import 'package:provider/provider.dart';

import 'Archive/archief_widget.dart';
import 'api/api_general.dart';
import 'homescreen/homescreen_widget.dart';
import 'menukaarten_widget.dart';
import 'meplijst/mep_lijst_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApiData>(
        create: (_) => ApiData(),
        builder: (context, child) {
          return MaterialApp(
            title: 'MEP-chat',
            initialRoute: '/login',
            routes: {
              '/login': (context) => LoginScreen(),
              '/meplijst': (context) => const MepLijstWidget(),
              '/archief': (context) => const ArchiefWidget(),
              '/menukaarten': (context) => const MenuKaartenWidget(),
              '/recepturen': (context) => const RecepturenWidget(),
            },
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const MyHomePage(title: 'MEP-chat Home Page'),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomescreenWidget(),
    MepPageWrapperWidget(),
    ArchiefWidget(),
    TeamsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt,
            ),
            label: 'M.E.P.',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.archive_outlined,
            ),
            label: 'Archief',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people_outline,
            ),
            label: 'Teams',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.blueGrey,
        onTap: _onItemTapped,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
