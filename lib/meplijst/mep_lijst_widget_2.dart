import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// stores ExpansionPanel state information
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  final List<String> meps = ["Garde", "Ovenkant", "Roti", "Desserts", "Lunch"];

  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: meps[index],
      expandedValue: 'This is item number $index',
    );
  });
}

class MepLijstWidget2 extends StatefulWidget {
  const MepLijstWidget2({super.key});

  @override
  State<MepLijstWidget2> createState() => _MepLijstWidget2State();
}

class _MepLijstWidget2State extends State<MepLijstWidget2> {
  final List<Item> _data = generateItems(5);

  void addItem(String title, List<Item> list) {
    final List<String> meps = [
      "Garde",
      "Ovenkant",
      "Roti",
      "Desserts",
      "Lunch"
    ];

    setState(() {
      list.add(Item(
          headerValue: title,
          expandedValue: 'This is item number ${list.length}'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MEP-lijsten"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.black12,
            icon: Icon(
              Icons.abc,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt,
            ),
            label: 'M.E.P.',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_post_office_outlined,
              color: Colors.black,
            ),
            label: 'Archief',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people_outline,
              color: Colors.black,
            ),
            label: 'Teams',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: _buildPanel(),
            ),
            IconButton(
              color: Colors.black,
              onPressed: () {
                addItem("Title", _data);
              },
              icon: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              leading: FaIcon(FontAwesomeIcons.clipboard),
              title: Text(item.headerValue),
            );
          },
          body: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                color: Colors.redAccent,
                onPressed: () {},
                icon: Icon(Icons.offline_bolt_outlined),
              ),
              IconButton(
                color: Colors.blueAccent,
                onPressed: () {},
                icon: Icon(Icons.settings_applications_outlined),
              ),
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      action: SnackBarAction(
                        label: 'Action',
                        onPressed: () {
                          // Code to execute.
                        },
                      ),
                      content: const Text('Item has been deleted.'),
                      duration: const Duration(milliseconds: 3000),
                      width: 280.0,
                      // Width of the SnackBar.
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, // Inner padding for SnackBar content.
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  );
                  setState(() {
                    _data
                        .removeWhere((Item currentItem) => item == currentItem);
                  });
                },
                icon: Icon(Icons.delete),
                color: Colors.redAccent,
              ),
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      action: SnackBarAction(
                        label: 'Action',
                        onPressed: () {
                          // Code to execute.
                        },
                      ),
                      content: const Text('Item has been archived.'),
                      duration: const Duration(milliseconds: 3000),
                      width: 280.0,
                      // Width of the SnackBar.
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, // Inner padding for SnackBar content.
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  );
                  //TODO make archive method work
                  setState(() {
                    _data
                        .removeWhere((Item currentItem) => item == currentItem);
                  });
                },
                icon: Icon(Icons.archive_outlined),
                color: Colors.blueAccent,
              )
            ],
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
