import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../api/api_general.dart';

class HomescreenWidget extends StatefulWidget {
  const HomescreenWidget({Key? key}) : super(key: key);

  @override
  State<HomescreenWidget> createState() => _HomescreenWidgetState();
}

class _HomescreenWidgetState extends State<HomescreenWidget> {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<ApiData>(context, listen: false).getApiKey == "") {
      context.go('/login');
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Center(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: DelayedDisplay(
                          delay: Duration(milliseconds: 200),
                          child: Text(
                              "Welcome back, ${Provider.of<ApiData>(context, listen: false).getUserName()}",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DelayedDisplay(
                          delay: Duration(milliseconds: 400),
                          // TODO change to real amount
                          child: Text(
                              "You currently have {int} amount of items open")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DelayedDisplay(
                          delay: Duration(milliseconds: 500),
                          // TODO change to real amount
                          child: Text(
                              "Click the navigation bar to see your items")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: const [],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
