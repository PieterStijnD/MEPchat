import 'package:flutter/material.dart';
import 'package:new_base/meplijst/single_mep_lijst_widget.dart';

class MepLijstWidget extends StatefulWidget {
  const MepLijstWidget({Key? key}) : super(key: key);

  @override
  State<MepLijstWidget> createState() => _MepLijstWidgetState();
}

class _MepLijstWidgetState extends State<MepLijstWidget> {
  final List<dynamic> entries = <SingleMepLijstWidget>[
    SingleMepLijstWidget(
      title: 'Mep-item 1',
      active: true,
    ),
    SingleMepLijstWidget(
      title: 'Mep-item 2',
      active: true,
    ),
    SingleMepLijstWidget(
      title: 'Mep-item 3',
      active: true,
    ),
    SingleMepLijstWidget(
      title: 'Mep-item 4',
      active: true,
    ),
    SingleMepLijstWidget(
      title: 'Mep-item 5',
      active: true,
    ),
    SingleMepLijstWidget(
      title: 'Mep-item 6',
      active: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MEP-lijsten"),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.white70,
            child: Center(child: Text('Entry ${entries[index]}')),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      // SingleChildScrollView(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //
      //       SingleMepLijstWidget(
      //         title: 'Mep-item',
      //         active: true,
      //       ),
      //       SingleMepLijstWidget(
      //         title: 'Mep-item',
      //         active: true,
      //       ),
      //       SingleMepLijstWidget(
      //         title: 'Mep-item',
      //         active: true,
      //       ),
      //       SingleMepLijstWidget(
      //         title: 'Mep-item',
      //         active: true,
      //       ),
      //       IconButton(
      //           color: Colors.black, onPressed: add(), icon: Icon(Icons.add))
      //     ],
      //   ),
      // ),
    );
  }

  add() {}
}
