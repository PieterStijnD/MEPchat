import 'package:flutter/material.dart';

class MenuKaartenWidget extends StatefulWidget {
  const MenuKaartenWidget({Key? key}) : super(key: key);

  @override
  State<MenuKaartenWidget> createState() => _MenuKaartenWidgetState();
}

class _MenuKaartenWidgetState extends State<MenuKaartenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menukaarten"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("Menukaarten"),
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
