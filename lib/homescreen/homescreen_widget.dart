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
      body: Column(
        children: [
          //TODO make into functioning search field, perhaps find one at pub.dev?
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                autofocus: false,
                decoration: InputDecoration(
                  iconColor: Colors.grey,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Center(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("hello")
                          // homescreen_button_widget(
                          //   title: 'MEP-Lijsten',
                          //   path: 'meplijst',
                          //   icon: Icon(
                          //     Icons.featured_play_list_outlined,
                          //     size: 108,
                          //     color: Colors.blueAccent,
                          //   ),
                          // ),
                          // homescreen_button_widget(
                          //   title: 'Menukaarten',
                          //   path: 'menukaarten',
                          //   icon: Icon(
                          //     Icons.book_outlined,
                          //     size: 108,
                          //     color: Colors.blueAccent,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Text("hello")

                          // homescreen_button_widget(
                          //   title: 'Archief',
                          //   path: 'archief',
                          //   icon: Icon(
                          //     Icons.archive_outlined,
                          //     size: 108,
                          //     color: Colors.blueAccent,
                          //   ),
                          // ),
                          // homescreen_button_widget(
                          //   title: 'Recepturen',
                          //   path: 'recepturen',
                          //   icon: Icon(
                          //     Icons.list_alt_outlined,
                          //     size: 108,
                          //     color: Colors.blueAccent,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
