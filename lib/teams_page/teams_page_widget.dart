import 'package:flutter/material.dart';

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
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Current logged in user:"),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("P.S. Doeleman"),
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Current user level:"),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("admin"),
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Completed tasks:"),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("0"),
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
          ],
        ),
      ),
    );
  }
}
