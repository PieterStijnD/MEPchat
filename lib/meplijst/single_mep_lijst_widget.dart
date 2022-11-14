import 'package:flutter/material.dart';

class SingleMepLijstWidget extends StatelessWidget {
  const SingleMepLijstWidget({
    Key? key,
    required this.title,
    required this.active,
  }) : super(key: key);

  final String title;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.list_alt),
              Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                  child: Text(title)),
              Spacer(),
              Icon(Icons.more_vert)
            ],
          ),
        ),
      ),
    );
  }
}
