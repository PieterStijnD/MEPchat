import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_base/api/api_user_calls.dart';
import 'package:new_base/login_page.dart';
import 'package:new_base/meplijst/mep_page_wrapper_widget.dart';
import 'package:new_base/photo_page/photo_parser_widget.dart';
import 'package:new_base/recipe_page/recepturen_widget.dart';
import 'package:new_base/teams_page/teams_page_widget.dart';
import 'package:provider/provider.dart';

import 'Archive/archief_widget.dart';
import 'api/api_general.dart';
import 'file_page/file_page.dart';
import 'homescreen/homescreen_widget.dart';
import 'menu_kaarten/menukaarten_widget.dart';
import 'meplijst/mep_lijst_recepten.dart';
import 'meplijst/mep_lijst_widget.dart';
import 'photo_page/camera_page.dart';

void main() {
  runApp(const MyApp());
}

/// The route configuration.
final GoRouter _router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) =>
          // pass the original location to the LoginPage (if there is one)
          LoginScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage(title: 'MEP-chat Home Page');
      },
      routes: [
        GoRoute(
          name: 'meplijstoverlay',
          path: 'meplijstoverlay',
          builder: (BuildContext context, GoRouterState state) {
            String data = "";
            data = state.extra as String;
            return MepLijstRecepten(
              title: data,
            );
          },
        ),
        GoRoute(
          name: 'photoparser',
          path: 'photoparser',
          builder: (BuildContext context, GoRouterState state) {
            List<String> data = state.extra as List<String>;
            return PhotoParserWidget(
              sentences: data,
            );
          },
        ),

        GoRoute(
          name: 'meplijst',
          path: 'meplijst',
          builder: (BuildContext context, GoRouterState state) {
            return MepLijstWidget();
          },
        ),
        GoRoute(
          path: 'archief',
          builder: (BuildContext context, GoRouterState state) {
            return ArchiefWidget();
          },
        ),
        GoRoute(
          path: 'menukaarten',
          builder: (BuildContext context, GoRouterState state) {
            return MenuKaartenWidget();
          },
        ),
        GoRoute(
          path: 'recepturen',
          builder: (BuildContext context, GoRouterState state) {
            return RecipesWidget();
          },
        ),
        GoRoute(
          path: 'camera',
          builder: (BuildContext context, GoRouterState state) {
            return CameraWidget();
          },
        ),
        // GoRoute(
        //   name: 'photoparser',
        //   path: 'photoparser',
        //   builder: (BuildContext context, GoRouterState state) {
        //     List<String> data = state.extra as List<String>;
        //     return PhotoParserWidget(
        //       sentences: data,
        //     );
        //   },
        // ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApiData>(
        create: (_) => ApiData(),
        builder: (context, child) {
          return MaterialApp.router(
            title: 'MEP-chat',
            routerConfig: _router,
            // initialRoute: '/login',
            // routes: {
            //   '/login': (context) => LoginScreen(),
            //   '/meplijst': (context) => const MepLijstWidget(),
            //   '/archief': (context) => const ArchiefWidget(),
            //   '/menukaarten': (context) => const MenuKaartenWidget(),
            //   '/recepturen': (context) => const RecipesWidget(),
            // },
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            // home: const MyHomePage(title: 'MEP-chat Home Page'),
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
    CameraWidget(),
    FileWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white70,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                logOutAndNavigateToStart();
              },
              icon: Icon(Icons.logout))
        ],
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
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt_outlined,
            ),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.arrow_downward,
            ),
            label: 'Files',
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

  void logOutAndNavigateToStart() {
    logOutUser(context);
    context.go('/login');
  }
}
