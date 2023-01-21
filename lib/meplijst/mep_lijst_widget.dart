import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:new_base/api/api_meplijsten.dart';

import 'mep_lijst_overlay.dart';

// stores ExpansionPanel state information
class Item {
  Item({
    required this.id,
    required this.isActive,
    required this.expandedValue,
    required this.headerValue,
  });

  int id;
  bool isActive;
  String expandedValue;
  String headerValue;
}

final List<String> meps2 = [
  "TEST",
  "Rouille",
  "TEST",
  "Ovenkant",
  "TEST",
  "Desserts",
  "TEST",
];

List<Item> generateItems(int numberOfItems, List<String> meps) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      id: index,
      isActive: true,
      headerValue: meps[index],
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
  late Future<List<Item>> fetchedMepLijsten =
      getMepLijstenFromServerAsListItems(context);
  final List<Item> _data2 = generateItems(meps2.length, meps2);
  final _formKey = GlobalKey<FormState>();
  bool _activeItemsList = true;

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
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasData || snapshot.data != null) {
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
                  FutureBuilder(
                    future: fetchedMepLijsten,
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasData || snapshot.data != null) {
                        return Column(children: [
                          ..._buildListOfEnabledSlidables(snapshot.data!)
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
              ],
            ),
          ),
        ),
      ],
    );
  }

  void addItem(String title, context) async {
    int code = 0;
    code = await postMepLijst(title, context);
    debugPrint(code.toString());
    if (code != 0) {
      setState(() {
        fetchedMepLijsten = getMepLijstenFromServerAsListItems(context);
      });
    }
  }

  void removeItem(int id, BuildContext context) async {
    int code = 0;
    code = await deleteMepLijst(id, context);
    debugPrint(code.toString());
    if (code != 0) {
      setState(() {
        fetchedMepLijsten = getMepLijstenFromServerAsListItems(context);
      });
    }
  }

  void flipEnabledItem(int id, BuildContext context) async {
    int code = 0;
    code = await deleteMepLijst(id, context);
    debugPrint(code.toString());
    if (code != 0) {
      setState(() {
        fetchedMepLijsten = getMepLijstenFromServerAsListItems(context);
      });
    }
  }

  List<Widget> _buildListOfSlidables(List<Item> data) {
    List<Widget> list = [];
    for (var item in data) {
      list.add(_buildSlidable(item, data.indexOf(item)));
    }
    return list;
  }

  List<Widget> _buildListOfEnabledSlidables(List<Item> data) {
    List<Widget> list = [];
    for (var item in data) {
      if (!item.isActive) {
        list.add(_buildSlidable(item, data.indexOf(item)));
      }
    }
    return list;
  }

  Widget _buildSlidable(Item data, int i) {
    return Slidable(
      key: ValueKey(i),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {
              removeItem(data.id, context);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: null,
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            icon: Icons.power_settings_new,
            label: 'In/Active',
          ),
        ],
      ),
      endActionPane: const ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: null,
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
        ],
      ),
      child: ListTile(
        title: Text('${data.headerValue}'),
        onTap: () => {
          Navigator.of(context)
              .push(MepLijstOverlay(title: data.headerValue, data: _data2))
        },
      ),
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
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
                            if (_formKey.currentState!.validate()) {
                              addItem(MEPController.text, context);
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
          ],
        );
      },
    );
  }
}
