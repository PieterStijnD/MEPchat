import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../api/api_meplijsten.dart';
import 'mep_lijst_widget.dart';

class MepLijstRecepten extends StatefulWidget {
  final String title;

  const MepLijstRecepten({Key? key, required this.title}) : super(key: key);

  @override
  State<MepLijstRecepten> createState() => _MepLijstReceptenState();
}

class _MepLijstReceptenState extends State<MepLijstRecepten> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(child: _buildOverlayContent(widget.title, context)),
    );
  }

  Widget _buildOverlayContent(String title, BuildContext context) {
    String _title = title;
    bool _vandaag = true;

    final List<String> meps2 = [
      "Paprika Rouille",
      "Dashi",
      "Knolselderij Salade",
      "Pesto",
    ];

    final List<String> meps = [
      "Aguachillle",
      "Bisque",
      "Dashi",
      "Fishtaco vulling",
      "Knolselderij Salade",
      "Kruidenboter",
      "Mosterdsoep",
      "Paprika Rouille",
      "Pesto",
      "Zeebaars cevice",
    ];

    List<MepListClass> generateItems(int numberOfItems, List<String> meps) {
      return List<MepListClass>.generate(numberOfItems, (int index) {
        return MepListClass(
          id: index,
          isActive: true,
          headerValue: meps[index],
        );
      });
    }

    List<MepListClass> fruitList = generateItems(meps2.length, meps2);
    List<MepListClass> vegetableList = generateItems(meps.length, meps);

    final formKey = GlobalKey<FormState>();

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
              child: Text("${_title}: Recepten",
                  style: TextStyle(color: Colors.white, fontSize: 20))),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white),
                ),
                onPressed: () =>
                    // TODO changed external state isnt optimal, consider building a controller or reworking this widget into a stateful widget
                    {setState(() => _vandaag = true)},
                child: Text("Vandaag"),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white),
                ),
                onPressed: () =>
                    // TODO changed external state isnt optimal, consider building a controller or reworking this widget into a stateful widget
                    {setState(() => _vandaag = false)},
                child: Text("Morgen"),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (_vandaag) ...[..._buildListOfSlidables(vegetableList)],
                  if (!_vandaag) ...[..._buildListOfSlidables(fruitList)]
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: const [
                FaIcon(
                  FontAwesomeIcons.sliders,
                  color: Colors.amberAccent,
                ),
                SizedBox(width: 15),
                FaIcon(
                  FontAwesomeIcons.powerOff,
                  color: Colors.redAccent,
                ),
              ],
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              BackButton(
                color: Colors.white,
                onPressed: () => context.pop(),
              ),
              IconButton(
                onPressed: () {
                  showFormDialog(context);
                },
                color: Colors.white,
                icon: Icon(
                  Icons.add,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _buildListOfSlidables(List<MepListClass> data) {
    List<Widget> list = [];
    for (int i = 0; i < data.length; i++) {
      list.add(_buildSlidable(data[i], i));
    }
    return list;
  }

  Widget _buildSlidable(MepListClass data, int i) {
    return Slidable(
      key: ValueKey(i),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        children: const [
          SlidableAction(
            onPressed: null,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: null,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.power_settings_new,
            label: 'In/Active',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: const [
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
        title: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('${data.headerValue}'),
                ],
              ),
            )),
        onTap: () => print('Tapped'),
      ),
    );
  }

  void showFormDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final MEPController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Center(
            child: Text("Toevoegen Ingredient"),
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

  void addItem(String title, context) async {
    int code = 0;
    code = await postMepLijst(title, context);
    debugPrint(code.toString());
    // if (code != 0) {
    //   setState(() {
    //     fetchedMepLijsten = getMepLijstenFromServerAsListItems(context);
    //   });
    // }
  }
}
