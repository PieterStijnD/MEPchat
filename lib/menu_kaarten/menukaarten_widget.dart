import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

import '../api/api_menus.dart';

class MenuKaartenWidget extends StatefulWidget {
  const MenuKaartenWidget({Key? key}) : super(key: key);

  @override
  State<MenuKaartenWidget> createState() => _MenuKaartenWidgetState();
}

class _MenuKaartenWidgetState extends State<MenuKaartenWidget> {
  late Future<List<MenuClass>> fetchedMenuList = getMenusFromServer(context);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                FutureBuilder(
                  future: fetchedMenuList,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData || snapshot.data != null) {
                      return Column(children: [
                        // TODO change back to enabled Slidables?
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
            ),
          ),
        ),
      ],
    );
  }

  void addItem(String title, context) async {
    int code = 0;
    code = await postMenu(title, context);
    debugPrint(code.toString());
    if (code != 0) {
      setState(() {
        fetchedMenuList = getMenusFromServer(context);
      });
    }
  }

  void removeItem(int id, BuildContext context) async {
    int code = 0;
    code = await deleteMenu(id, context);
    debugPrint(code.toString());
    if (code != 0) {
      setState(() {
        fetchedMenuList = getMenusFromServer(context);
      });
    }
  }

  List<Widget> _buildListOfSlidables(List<MenuClass> data) {
    List<Widget> list = [];
    for (var item in data) {
      if (!item.archived!) {
        list.add(_buildSlidable(item.archived!, item, data.indexOf(item)));
      }
      // list.add(_buildSlidable(item.archived!, item, data.indexOf(item)));
    }
    return list;
  }

  void flipArchivedItem(bool isArchived, int id, BuildContext context) async {
    int code = 0;
    code = await switchArchivedMenuLijst(isArchived, id, context);
    debugPrint(code.toString());
    if (code != 0) {
      setState(() {
        fetchedMenuList = getMenusFromServer(context);
      });
    }
  }

  Widget _buildSlidable(bool isArchived, MenuClass data, int i) {
    return Slidable(
      key: ValueKey(i),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {
              removeItem(data.id!, context);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {
              flipArchivedItem(isArchived, data.id!, context);
            },
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
        ],
      ),
      child: ListTile(
        leading: Transform.rotate(
          angle: 20 * math.pi / 180,
          child: IconButton(
            icon: Icon(
              Icons.menu_book_outlined,
            ),
            onPressed: null,
          ),
        ),
        title: Text('${data.name}'),
        onTap: () => {
          showMenu(data.name!),
        },
      ),
    );
  }

  Future<void> showMenu(String name) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Menu'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(height: 24.0),
                Center(child: Text("$name")),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showFormDialog(BuildContext context) {
    final MEPController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Center(
            child: Text("Toevoegen Menukaart"),
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
                            context.pop();
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
                              context.pop();
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
