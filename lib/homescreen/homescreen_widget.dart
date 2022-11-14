import 'package:flutter/material.dart';

class HomescreenWidget extends StatefulWidget {
  const HomescreenWidget({Key? key}) : super(key: key);

  @override
  State<HomescreenWidget> createState() => _HomescreenWidgetState();
}

class _HomescreenWidgetState extends State<HomescreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homescreen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("Homescreen"),
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
