import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_base/meplijst/mep_lijst_widget.dart';

class TutorialOverlay extends ModalRoute<void> {
  final List<Item> _data;

  TutorialOverlay({required List<Item> data}) : _data = data;

  bool _vandaag = true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.9);

  @override
  String get barrierLabel => "Testing";

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: _buildOverlayContent(context),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    final List<String> meps2 = [
      "Banaan",
      "Appel",
      "Peer",
      "Zucchini",
      "Courgette",
      "Slagroom",
      "Aardbei"
    ];

    final List<String> meps = [
      "Strawberry",
      "Kiwi",
      "Banana",
      "Apple",
      "Pear",
      "Snickers",
      "Rocky Mountain Oysters",
      "Strawberry",
      "Kiwi",
      "Banana",
      "Apple",
      "Pear",
      "Snickers",
      "Rocky Mountain Oysters",
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

    List<Item> fruitList = generateItems(meps2.length, meps2);
    List<Item> vegetableList = generateItems(meps.length, meps);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white),
                ),
                onPressed: () =>
                    // TODO changed external state isnt optimal, consider building a controller or reworking this widget into a stateful widget
                    {setState(() => _vandaag = true), changedExternalState()},
                child: Text("Vandaag"),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white),
                ),
                onPressed: () =>
                    {setState(() => _vandaag = false), changedExternalState()},
                child: Text("Morgen"),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (_vandaag) ...[..._buildListOfSlidables(vegetableList)],
                  if (!_vandaag) ...[..._buildListOfSlidables(fruitList)]
                ],
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: const [
              FaIcon(
                FontAwesomeIcons.sliders,
                color: Colors.amberAccent,
              ),
              SizedBox(width: 10),
              FaIcon(
                FontAwesomeIcons.powerOff,
                color: Colors.redAccent,
              ),
            ],
          ),
          BackButton(
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
            // child: Text('Dismiss'),
          )
        ],
      ),
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
            child: Column(
              children: [
                Text('${data.headerValue}'),
                Text('${data.expandedValue}'),
              ],
            )),
        onTap: () => print('Tapped'),
      ),
    );
  }
}
