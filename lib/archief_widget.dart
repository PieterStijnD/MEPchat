import 'package:flutter/material.dart';

class ArchiefWidget extends StatefulWidget {
  const ArchiefWidget({Key? key}) : super(key: key);

  @override
  State<ArchiefWidget> createState() => _ArchiefWidgetState();
}

class _ArchiefWidgetState extends State<ArchiefWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Archief"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("Archief"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
