import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
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
    var apiKeyLoaded = context.watch<ApiData>().apiKey;
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
                      padding: const EdgeInsets.all(8.0),
                      child: DelayedDisplay(
                          delay: Duration(milliseconds: 200),
                          // TODO change to real name
                          child: Text("Welcome back, \$User")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DelayedDisplay(
                          delay: Duration(milliseconds: 300),
                          // TODO change to real amount
                          child: Text(
                              "You currently have X amount of items open")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DelayedDisplay(
                          delay: Duration(milliseconds: 300),
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
