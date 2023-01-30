import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_general.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({Key? key}) : super(key: key);

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                DelayedDisplay(
                  delay: Duration(milliseconds: 300),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Current logged in user:",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: 350),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        "${Provider.of<ApiData>(context, listen: false).getUserName()}"),
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
              ],
            ),
            Column(
              children: const [
                DelayedDisplay(
                  delay: Duration(milliseconds: 300),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Current user level:",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: 350),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("admin"),
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
              ],
            ),
            Column(
              children: const [
                DelayedDisplay(
                  delay: Duration(milliseconds: 300),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Completed tasks:",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: 350),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("0"),
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
