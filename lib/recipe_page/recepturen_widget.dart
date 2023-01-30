import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

import '../api/api_recipes.dart';

class RecipesWidget extends StatefulWidget {
  const RecipesWidget({Key? key}) : super(key: key);

  @override
  State<RecipesWidget> createState() => _RecipesWidgetState();
}

class _RecipesWidgetState extends State<RecipesWidget> {
  late Future<List<RecipeClass>> fetchedRecipeList =
      getRecipesFromServer(context);
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
            child: Column(
              children: [
                if (!_activeItemsList) ...[
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

  void addItem(String naam, String Volume, String Measurement,
      String Instructions, String Duration, String Time, context) async {
    int code = 0;
    Map body = {
      "name": naam,
      "volume": Volume,
      "unit": {"name": "g"},
      "description": "Description",
      "instructions": Instructions,
      "ingredients": [],
      "preparationTime": "600",
      "timeUnit": {"name": "uur"},
      "archived": false
    };

    code = await postRecipe(body, context);
    debugPrint(code.toString());
    if (code != 0) {
      setState(() {
        fetchedRecipeList = getRecipesFromServer(context);
      });
    }
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
      if (!item.archived!) {
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
            icon: Icons.archive,
            label: 'Archive',
          ),
        ],
      ),
      child: ListTile(
        leading: Transform.rotate(
          angle: 15 * math.pi / 180,
          child: IconButton(
            icon: Icon(
              Icons.restaurant_menu,
            ),
            onPressed: null,
          ),
        ),
        title: Text('${data.name}'),
        onTap: () => {showRecept(data.name!)},
      ),
    );
  }

  Future<void> showRecept(String name) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Recept'),
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
    final recipeNaamController = TextEditingController();
    final recipeVolumeController = TextEditingController();
    final recipeMeasurementController = TextEditingController();
    final recipeInstructionsController = TextEditingController();
    final recipeDurationController = TextEditingController();
    final recipeTimeController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Center(
            child: Text("Add Recipe"),
          ),
          children: [
            Form(
              key: _formKey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFieldWidget(
                      recipeController: recipeNaamController, label: "Naam"),
                  TextFieldWidget(
                      recipeController: recipeVolumeController,
                      label: "Volume"),
                  TextFieldWidget(
                      recipeController: recipeMeasurementController,
                      label: "Measurement"),
                  TextFieldWidget(
                      recipeController: recipeInstructionsController,
                      label: "Instructions"),
                  TextFieldWidget(
                      recipeController: recipeDurationController,
                      label: "Duration"),
                  TextFieldWidget(
                      recipeController: recipeTimeController,
                      label: "Time unit"),
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
                              addItem(
                                  recipeNaamController.text,
                                  recipeVolumeController.text,
                                  recipeMeasurementController.text,
                                  recipeInstructionsController.text,
                                  recipeDurationController.text,
                                  recipeTimeController.text,
                                  context);
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
