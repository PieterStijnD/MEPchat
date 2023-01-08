import 'package:flutter/material.dart';

class ArchiefWidget extends StatefulWidget {
  const ArchiefWidget({Key? key}) : super(key: key);

  @override
  State<ArchiefWidget> createState() => _ArchiefWidgetState();
}

class _ArchiefWidgetState extends State<ArchiefWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.archive_outlined,
            size: 200,
          ),
          CircularProgressIndicator(
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
