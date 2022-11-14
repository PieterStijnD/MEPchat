import 'package:flutter/material.dart';

class RecepturenWidget extends StatefulWidget {
  const RecepturenWidget({Key? key}) : super(key: key);

  @override
  State<RecepturenWidget> createState() => _RecepturenWidgetState();
}

class _RecepturenWidgetState extends State<RecepturenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recepturen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("Recepturen"),
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
