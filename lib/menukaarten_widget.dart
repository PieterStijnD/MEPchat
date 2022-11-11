import 'package:flutter/material.dart';

class MenuKaartenWidget extends StatefulWidget {
  const MenuKaartenWidget({Key? key}) : super(key: key);

  @override
  State<MenuKaartenWidget> createState() => _MenuKaartenWidgetState();
}

class _MenuKaartenWidgetState extends State<MenuKaartenWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Text("Archief"),
        ),
        Card(
          child: IconButton(
            onPressed: () {
              // Navigate to the second screen using a named route.
              Navigator.pop(context);
            },
            icon: const Icon(Icons.abc),
          ),
        ),
      ],
    );
  }
}
