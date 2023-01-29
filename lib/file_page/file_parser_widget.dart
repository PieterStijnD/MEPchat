import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../api/api_recipes.dart';
import '../common/recipe_body_creator.dart';

class FileParserWidget extends StatefulWidget {
  const FileParserWidget({Key? key, required this.sentences}) : super(key: key);

  final List<String> sentences;

  @override
  State<FileParserWidget> createState() => _FileParserWidgetState();
}

class _FileParserWidgetState extends State<FileParserWidget> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  late PlatformFile file;
  late List<String> sentences;

  List<String> _selectedDropDownButton = [];

  @override
  initState() {
    super.initState();
    sentences = widget.sentences;
    _selectedDropDownButton = List.filled(sentences.length, options[0]);
  }

  List<String> options = [
    "remove",
    "name",
    "volume",
    "unit",
    "description",
    "instructions",
    "ingredients",
    "preparationTime",
    "timeUnit",
    "archived"
  ];

  @override
  Widget build(BuildContext context) {
    late List<String> selectedOptions =
        List.filled(sentences.length, options[0]);

    void _selectOption(String option, int index) {
      setState(() {
        selectedOptions[index] = option;
      });
    }

    // This list of controllers can be used to set and get the text from/to the TextFields
    Map<String, TextEditingController> textEditingControllers = {};
    var textFields = <TextField>[];
    for (var str in sentences) {
      var textEditingController = TextEditingController(text: str);
      textEditingControllers.putIfAbsent(str, () => textEditingController);
      continue;
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: sentences.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 24.0, left: 16.0, right: 16.0),
                        child: TextFormField(
                            initialValue: sentences[index],
                            controller: textEditingControllers[index],
                            onChanged: (value) {
                              setState(() {
                                sentences[index] = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Sentence',
                            )),
                        // child: Text(widget.sentences[index]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: DropdownButton<String>(
                          value: _selectedDropDownButton[index],
                          onChanged: (newValue) {
                            setState(() {
                              _selectedDropDownButton[index] = newValue!;
                            });
                          },
                          items: options
                              .map((String option) => DropdownMenuItem<String>(
                                    value: option,
                                    child: Text(option),
                                  ))
                              .toList(),
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.blue,
                      ),
                    ],
                  );
                },
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    int code = 0;
                    Map body =
                        makeBodyForPost(sentences, _selectedDropDownButton);
                    code = await postRecipe(body, context);
                    debugPrint(code.toString());
                    if (code == 200) {
                      context.pop();
                      _showMyDialog();
                    }
                    if (code != 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error. Something went wrong.'),
                        ),
                      );
                    }
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('File parsing complete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                SizedBox(height: 24.0),
                Icon(Icons.check_circle_outline, color: Colors.green),
                Center(child: Text('Recipe saved.')),
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
}
