import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../api/api_menus.dart';

class MenuArchiveWidget extends StatefulWidget {
  const MenuArchiveWidget({Key? key}) : super(key: key);

  @override
  State<MenuArchiveWidget> createState() => _MenuArchiveWidgetState();
}

class _MenuArchiveWidgetState extends State<MenuArchiveWidget> {
  late Future<List<MenuClass>> fetchedMenuList = getMenusFromServer(context);
  final _formKey = GlobalKey<FormState>();
  bool _activeItemsList = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     TextButton(
        //       onPressed: () => setState(() => _activeItemsList = true),
        //       child: Text("Active"),
        //     ),
        //     TextButton(
        //       onPressed: () => setState(() => _activeItemsList = false),
        //       child: Text("All"),
        //     )
        //   ],
        // ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Expanded(
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
                          ..._buildListOfSlidables(snapshot.data!)
                        ]);
                      }
                      return Text("Empty");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
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

  void flipEnabledItem(int id, BuildContext context) async {
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
      list.add(_buildSlidable(item, data.indexOf(item)));
    }
    return list;
  }

  // TODO enabled on a menu?
  List<Widget> _buildListOfEnabledSlidables(List<MenuClass> data) {
    List<Widget> list = [];
    for (var item in data) {
      if (!item.enabled!) {
        list.add(_buildSlidable(item, data.indexOf(item)));
      }
    }
    return list;
  }

  Widget _buildSlidable(MenuClass data, int i) {
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
            icon: Icons.unarchive,
            label: 'Unarchive',
          ),
        ],
      ),
      child: ListTile(
        title: Text('${data.name}'),
        onTap: () => {
          // TODO , on tap, do what?
        },
      ),
    );
  }

// void showFormDialog(BuildContext context) {
//   final MEPController = TextEditingController();
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return SimpleDialog(
//         title: Center(
//           child: Text("Toevoegen MEP"),
//         ),
//         children: [
//           Form(
//             key: _formKey,
//             child: Column(
//               // crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text("Naam"),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 5,
//                           blurRadius: 7,
//                           offset: Offset(0, 3), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
//                       child: TextFormField(
//                         controller: MEPController,
//                         decoration: InputDecoration(
//                             border: InputBorder.none, hintText: "..."),
//                         // The validator receives the text that the user has entered.
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter some text';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: Text(
//                     "Of",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text("Receptuur toevoegen"),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 5,
//                           blurRadius: 7,
//                           offset: Offset(0, 3), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'zoek receptuur',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ElevatedButton(
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Colors.white),
//                         ),
//                         onPressed: () {
//                           context.pop();
//                         },
//                         child: Icon(
//                           Icons.cancel_outlined,
//                           color: Colors.amberAccent,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ElevatedButton(
//                         style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStateProperty.all(Colors.white)),
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             addItem(MEPController.text, context);
//                             context.pop();
//                           }
//                         },
//                         child: Icon(Icons.check_circle_outline,
//                             color: Colors.green),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           )
//         ],
//       );
//     },
//   );
// }
}
