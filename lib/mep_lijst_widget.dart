import 'package:flutter/material.dart';

class MepLijstWidget extends StatefulWidget {
  const MepLijstWidget({Key? key}) : super(key: key);

  @override
  State<MepLijstWidget> createState() => _MepLijstWidgetState();
}

class _MepLijstWidgetState extends State<MepLijstWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MEP-lijsten"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("MEP-lijsten"),
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
