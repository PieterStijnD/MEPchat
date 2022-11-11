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
          Card(
            child: IconButton(
              onPressed: () {
                // Navigate to the second screen using a named route.
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
        ],
      ),
    );
  }
}
