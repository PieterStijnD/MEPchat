import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:new_base/api/api_meplijsten.dart';

class MepListClass {
  MepListClass({
    required this.id,
    required this.isActive,
    required this.headerValue,
  });

  int id;
  bool isActive;
  String headerValue;
}

class MepLijstWidget extends StatefulWidget {
  const MepLijstWidget({super.key});

  @override
  State<MepLijstWidget> createState() => _MepLijstWidgetState();
}

class _MepLijstWidgetState extends State<MepLijstWidget> {
  late Future<List<MepLijstData>> fetchedMepLijsten =
      getMepLijstenFromServerAsListItems(context);
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

  void flipEnabledItem(bool isEnabled, int id, BuildContext context) async {
    int code = 0;
    code = await switchEnabledMepLijst(isEnabled, id, context);

    debugPrint(code.toString());
    if (code != 0) {
      setState(() {
        fetchedMepLijsten = getMepLijstenFromServerAsListItems(context);
      });
    }
  }

  void flipArchivedItem(bool isArchived, int id, BuildContext context) async {
    int code = 0;
    code = await switchArchivedMepLijst(isArchived, id, context);
    debugPrint(code.toString());
    if (code != 0) {
      setState(() {
        fetchedMepLijsten = getMepLijstenFromServerAsListItems(context);
      });
    }
  }

  List<Widget> _buildListOfSlidables(List<MepLijstData> data) {
    List<Widget> list = [];
    for (var item in data) {
      if (!item.archived!) {
        list.add(
            _buildSlidable(false, item.archived!, item, data.indexOf(item)));
      }
    }
    return list;
  }

  List<Widget> _buildListOfEnabledSlidables(List<MepLijstData> data) {
    List<Widget> list = [];
    for (var item in data) {
      if (item.enabled! && !item.archived!) {
        list.add(
            _buildSlidable(true, item.archived!, item, data.indexOf(item)));
      }
    }
    return list;
  }

  Widget _buildSlidable(
      bool isEnabled, bool isArchived, MepLijstData data, int i) {
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
          SlidableAction(
            onPressed: (_) {
              flipEnabledItem(isEnabled, data.id!, context);
            },
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            icon: Icons.power_settings_new,
            label: 'In/Active',
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
        // leading: Icon(Icons.pending_actions),
        leading: Transform.rotate(
          angle: 20 * math.pi / 180,
          child: IconButton(
            icon: Icon(
              Icons.pending_actions,
            ),
            onPressed: null,
          ),
        ),
        title: Text('${data.name}'),
        onTap: () => {
          // TODO send data to overlay or fetch data from server in overlay
          context.goNamed(
            "meplijstoverlay",
            extra: data.name,
          ),
          // Navigator.of(context).push(MepLijstOverlay(title: data.headerValue))
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
