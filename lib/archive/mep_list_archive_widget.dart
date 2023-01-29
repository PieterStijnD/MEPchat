import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:new_base/api/api_meplijsten.dart';

// // stores ExpansionPanel state information
// class MepListClass {
//   MepListClass({
//     required this.id,
//     required this.isActive,
//     required this.headerValue,
//   });
//
//   int id;
//   bool isActive;
//   String headerValue;
// }

class MepListArchiveWidget extends StatefulWidget {
  const MepListArchiveWidget({super.key});

  @override
  State<MepListArchiveWidget> createState() => _MepListArchiveWidgetState();
}

class _MepListArchiveWidgetState extends State<MepListArchiveWidget> {
  late Future<List<MepLijstData>> fetchedMepLijsten =
      getMepLijstenFromServerAsListItems(context);
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
                  // Center(
                  //   child: IconButton(
                  //     color: Colors.black,
                  //     onPressed: () {
                  //       showFormDialog(context);
                  //     },
                  //     icon: Icon(Icons.add),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // void addItem(String title, context) async {
  //   int code = 0;
  //   code = await postMepLijst(title, context);
  //   debugPrint(code.toString());
  //   if (code != 0) {
  //     setState(() {
  //       fetchedMepLijsten = getMepLijstenFromServerAsListItems(context);
  //     });
  //   }
  // }

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

  List<Widget> _buildListOfSlidables(List<MepLijstData> data) {
    List<Widget> list = [];
    for (var item in data) {
      if (item.archived == true) {
        list.add(_buildSlidable(item, data.indexOf(item)));
      }
    }
    return list;
  }

  Widget _buildSlidable(MepLijstData data, int i) {
    // TODO filter archive and remove
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
        title: Text('${data.name!}'),
        onTap: () => {},
      ),
    );
  }
}
