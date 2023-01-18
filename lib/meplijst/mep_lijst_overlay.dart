import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_base/meplijst/mep_lijst_widget.dart';

class TutorialOverlay extends ModalRoute<void> {
  final List<Item> _data;

  TutorialOverlay({required List<Item> data}) : _data = data;

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
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white),
                ),
                onPressed: () {},
                child: Text("Vandaag"),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white),
                ),
                onPressed: () {},
                child: Text("Morgen"),
              ),
            ],
          ),
          ..._buildListOfSlidables(_data),
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

// @override
// Widget buildTransitions(BuildContext context, Animation<double> animation,
//     Animation<double> secondaryAnimation, Widget child) {
//   // You can add your own animations for the overlay content
//   return FadeTransition(
//     opacity: animation,
//     child: ScaleTransition(
//       scale: animation,
//       child: child,
//     ),
//   );
// }

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
            flex: 2,
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
              border: Border.all(color: Colors.white),
              color: Colors.blueGrey,
            ),
            child: Text('${data.headerValue}')),
        onTap: () => print('Tapped'),
      ),
    );
  }
}
