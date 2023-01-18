import 'package:flutter/material.dart';

class SingleMepLijstWidget extends StatefulWidget {
  const SingleMepLijstWidget({
    Key? key,
    required this.title,
    required this.active,
  }) : super(key: key);

  final String title;
  final bool active;

  @override
  State<SingleMepLijstWidget> createState() => _SingleMepLijstWidgetState();
}

class _SingleMepLijstWidgetState extends State<SingleMepLijstWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                print("log out");
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.list_alt),
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                      child: Text(widget.title)),
                  Spacer(),
                  Icon(Icons.more_vert)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
