import 'package:flutter/material.dart';

class homescreen_button_widget extends StatelessWidget {
  const homescreen_button_widget({
    Key? key,
    required this.title,
    required this.path,
  }) : super(key: key);

  final String title;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: Container(
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.archive_outlined,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  title,
                )
              ],
            )),
        onTap: () {
          Navigator.pushNamed(context, '/$path');
        },
      ),
    );
  }
}
