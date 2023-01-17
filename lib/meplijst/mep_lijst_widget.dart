import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:new_base/api/api_meplijsten.dart';

// stores ExpansionPanel state information
class Item {
  Item({
    required this.isActive,
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  bool isActive;
  String expandedValue;
  String headerValue;
  bool isExpanded;
}

final List<String> meps2 = [
  "TEST",
  "Rouille",
  "TEST",
  "Ovenkant",
  "TEST",
  "Desserts",
  "TEST"
];

List<Item> generateItems(int numberOfItems, List<String> meps) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      isExpanded: false,
      isActive: true,
      headerValue: meps[index],
      expandedValue: 'This is item number $index',
    );
  });
}

List<Item> generateItems2(int numberOfItems, List<MepLijstData> meps) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      isExpanded: false,
      isActive: true,
      headerValue: meps[index].name!,
      expandedValue: 'This is item number $index',
    );
  });
}

class MepLijstWidget extends StatefulWidget {
  const MepLijstWidget({super.key});

  @override
  State<MepLijstWidget> createState() => _MepLijstWidgetState();
}

class _MepLijstWidgetState extends State<MepLijstWidget> {
  //TODO make dynamic length
  late Future<List<Item>> fetchedMepLijsten =
      getMepLijstenFromServerAsListItems(context);
  final List<Item> _data2 = generateItems(7, meps2);
  final _formKey = GlobalKey<FormState>();
  bool _activeItemsList = true;

  void addItem(String title, List<Item> list) {
    setState(() {
      list.add(Item(
          isExpanded: false,
          isActive: true,
          headerValue: title,
          expandedValue: 'This is item number ${list.length}'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () => setState(() => _activeItemsList = true),
              child: Text("Active"),
            ),
            TextButton(
              onPressed: () => setState(() => _activeItemsList = false),
              child: Text("All"),
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                if (!_activeItemsList) ...[
                  FutureBuilder(
                    future: fetchedMepLijsten,
                    builder: (BuildContext context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasData) {
                        return Column(children: [
                          ..._buildListOfSlidables(snapshot.data!)
                        ]);
                      }
                      return Text("Empty");
                    },
                  ),
                  IconButton(
                    color: Colors.black,
                    onPressed: () {
                      showFormDialog(context);
                    },
                    icon: Icon(Icons.add),
                  )
                ],
                if (_activeItemsList) ...[
                  Column(
                    children: [
                      ..._buildListOfSlidables(_data2),
                    ],
                  ),
                  IconButton(
                    color: Colors.black,
                    onPressed: () {
                      showFormDialog(context);
                    },
                    icon: Icon(Icons.add),
                  )
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildListOfSlidables(List<Item> data) {
    List<Widget> list = [];
    for (int i = 0; i < data.length; i++) {
      list.add(_buildSlidable(data[i], i));
    }
    return list;
  }

  Widget _buildSlidable(Item data, int i) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: ValueKey(i),
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),
        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),
        // All actions are defined in the children parameter.
        children: const [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: null,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: const ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: null,
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
        ],
      ),
      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: ListTile(title: Text('${data.headerValue}')),
    );
  }

  void showFormDialog(BuildContext context) {
    final MEPController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: Center(
                child: Text("Toevoegen MEP"),
              ),
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Naam"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: TextFormField(
                              controller: MEPController,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: "..."),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "Of",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Receptuur toevoegen"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'zoek receptuur',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.cancel_outlined,
                                color: Colors.amberAccent,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              onPressed: () {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  //TODO make AddItem into api request
                                  // addItem(MEPController.text, _data);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Processing Data'),
                                    ),
                                  );
                                  Navigator.pop(context);
                                }
                              },
                              child: Icon(Icons.check_circle_outline,
                                  color: Colors.green),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ]);
        });
  }
}
