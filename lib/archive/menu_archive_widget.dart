import 'dart:math' as math;

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
      if (item.archived!) {
        list.add(_buildSlidable(item, data.indexOf(item)));
      }
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
        ],
      ),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {
              flipArchivedItem(data.archived!, data.id!, context);
            },
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.unarchive,
            label: 'Unarchive',
          ),
        ],
      ),
      child: ListTile(
        leading: Transform.rotate(
          angle: 15 * math.pi / 180,
          child: IconButton(
            icon: Icon(
              Icons.archive_outlined,
            ),
            onPressed: null,
          ),
        ),
        title: Text('${data.name}'),
        onTap: () => {
          // TODO , on tap, do what?
        },
      ),
    );
  }
}
