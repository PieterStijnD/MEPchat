import 'package:flutter/material.dart';
import 'package:new_base/meplijst/single_mep_lijst_widget.dart';

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleMepLijstWidget(
              title: 'Mep-item',
              active: true,
            ),
            SingleMepLijstWidget(
              title: 'Mep-item',
              active: true,
            ),
            SingleMepLijstWidget(
              title: 'Mep-item',
              active: true,
            ),
            SingleMepLijstWidget(
              title: 'Mep-item',
              active: true,
            ),
            IconButton(
                color: Colors.black, onPressed: add(), icon: Icon(Icons.add))
          ],
        ),
      ),
    );
  }

  add() {}
}
