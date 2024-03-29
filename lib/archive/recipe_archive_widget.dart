import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../api/api_recipes.dart';

class RecipeArchiveWidget extends StatefulWidget {
  const RecipeArchiveWidget({Key? key}) : super(key: key);

  @override
  State<RecipeArchiveWidget> createState() => _RecipeArchiveWidgetState();
}

class _RecipeArchiveWidgetState extends State<RecipeArchiveWidget> {
  late Future<List<RecipeClass>> fetchedRecipeList =
      getRecipesFromServer(context);
  final _formKey = GlobalKey<FormState>();
  bool _activeItemsList = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Expanded(
              child: Column(
                children: [
                  FutureBuilder(
                    future: fetchedRecipeList,
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
    code = await deleteRecipe(id, context);
    debugPrint(code.toString());
    if (code != 0) {
      setState(() {
        fetchedRecipeList = getRecipesFromServer(context);
      });
    }
  }

  void flipArchivedItem(bool isArchived, int id, BuildContext context) async {
    int code = 0;
    code = await switchArchivedRecipe(isArchived, id, context);
    debugPrint(code.toString());
    if (code != 0) {
      setState(() {
        fetchedRecipeList = getRecipesFromServer(context);
      });
    }
  }

  List<Widget> _buildListOfSlidables(List<RecipeClass> data) {
    List<Widget> list = [];
    for (var item in data) {
      if (item.archived == true) {
        list.add(_buildSlidable(item, data.indexOf(item)));
      }
    }
    return list;
  }

  Widget _buildSlidable(RecipeClass data, int i) {
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
              label: 'Unarchive'),
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

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.recipeController,
    required this.label,
  }) : super(key: key);

  final TextEditingController recipeController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
            controller: recipeController,
            decoration:
                InputDecoration(border: InputBorder.none, hintText: label),
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
    );
  }
}
