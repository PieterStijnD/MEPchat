import 'package:flutter/material.dart';

class MepLijstWidget extends StatefulWidget {
  const MepLijstWidget({Key? key}) : super(key: key);

  @override
  State<MepLijstWidget> createState() => _MepLijstWidgetState();
}

class _MepLijstWidgetState extends State<MepLijstWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Text("Mep-Lijsten"),
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
