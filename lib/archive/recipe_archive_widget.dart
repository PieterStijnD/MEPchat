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
                  // if (!_activeItemsList) ...[
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
                  Center(
                    child: IconButton(
                      color: Colors.black,
                      onPressed: () {
                        showFormDialog(context);
                      },
                      icon: Icon(Icons.add),
                    ),
                  )
                  // ],
                  // if (_activeItemsList) ...[
                  //   FutureBuilder(
                  //     future: fetchedRecipeList,
                  //     builder: (BuildContext context, snapshot) {
                  //       if (snapshot.connectionState != ConnectionState.done) {
                  //         return Center(child: CircularProgressIndicator());
                  //       }
                  //       if (snapshot.hasData || snapshot.data != null) {
                  //         return Column(children: [
                  //           // TODO change back to enabled Slidables?
                  //           ..._buildListOfSlidables(snapshot.data!)
                  //         ]);
                  //       }
                  //       return Text("Empty");
                  //     },
                  //   ),
                  //   IconButton(
                  //     color: Colors.black,
                  //     onPressed: () {
                  //       showFormDialog(context);
                  //     },
                  //     icon: Icon(Icons.add),
                  //   )
                  // ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void addItem(String title, context) async {
    int code = 0;
    code = await postRecipe(title, context);
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

  void flipEnabledItem(int id, BuildContext context) async {
    int code = 0;
    code = await deleteRecipe(id, context);
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
      list.add(_buildSlidable(item, data.indexOf(item)));
    }
    return list;
  }

  // TODO enabled on a menu?
  List<Widget> _buildListOfEnabledSlidables(List<RecipeClass> data) {
    List<Widget> list = [];
    for (var item in data) {
      if (!item.enabled!) {
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
            icon: Icons.archive,
            label: 'Archive',
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

  void showFormDialog(BuildContext context) {
    final recipeController = TextEditingController();
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
                      recipeController: recipeController, label: "Naam"),
                  TextFieldWidget(
                      recipeController: recipeController, label: "Volume"),
                  TextFieldWidget(
                      recipeController: recipeController, label: "Measurement"),
                  TextFieldWidget(
                      recipeController: recipeController,
                      label: "Instructions"),
                  TextFieldWidget(
                      recipeController: recipeController, label: "Duration"),
                  TextFieldWidget(
                      recipeController: recipeController, label: "Time unit"),
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
                            Navigator.pop(context);
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
                              addItem(recipeController.text, context);
                              Navigator.pop(context);
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
