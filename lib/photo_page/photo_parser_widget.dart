import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../api/api_recipes.dart';

class PhotoParserWidget extends StatefulWidget {
  final List<String> sentences;

  const PhotoParserWidget({super.key, required this.sentences});

  @override
  PhotoParserWidgetState createState() => PhotoParserWidgetState();
}

class PhotoParserWidgetState extends State<PhotoParserWidget> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void _handleSubmitted() {
    final FormState? form = _formKey.currentState;
    if (!form!.validate()) {
    } else {
      form.save();

      // User.instance.save().then((result) {
      //   print("Saving done: ${result}.");
      //   Navigator.pop(context);
      // });
    }
  }

  List<String> sentences = [];
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
                itemCount: widget.sentences.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Form(
                      //   key: _formKey,
                      //   // autovalidate: _autovalidate,
                      //   // onWillPop: _warnUserAboutInvalidData,
                      //   child: ListView(
                      //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      //     children: <Widget>[
                      //       for (var item in sentences)
                      //         Container(
                      //           child: TextFormField(
                      //             initialValue: item,
                      //             autocorrect: false,
                      //             controller: textEditingControllers[
                      //                 sentences.indexOf(item)],
                      //             // onSaved: (String value) {
                      //             //   sentences[item] = value;
                      //             // },
                      //           ),
                      //         ),
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 24.0, left: 16.0, right: 16.0),
                        child: TextFormField(
                            initialValue: widget.sentences[index],
                            controller: textEditingControllers[index],
                            onChanged: (value) {
                              setState(() {
                                widget.sentences[index] = value;
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
                    Map body = makeBodyForPost();
                    code = await postRecipe(body, context);
                    debugPrint(code.toString());
                    context.pop();
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

  Map makeBodyForPost() {
    Map<String, String> combined = {
      for (var i = 0; i < sentences.length; i++)
        sentences[i]: _selectedDropDownButton[i]
    };

    Map body = {
      "name": "",
      "volume": 0,
      "unit": {"name": "g"},
      "description": "",
      "instructions": "",
      "ingredients": [],
      "preparationTime": 600,
      "timeUnit": {"name": "uur"},
      "archived": false
    };
    for (var item in combined.entries) {
      if (item.value == "name") {
        body["name"] = body["name"] + " " + item.key;
      }
    }
    for (var item in combined.entries) {
      if (item.value == "volume") {
        body["volume"] = body["volume"] + " " + item.key;
      }
    }
    for (var item in combined.entries) {
      if (item.value == "unit") {
        body["unit"] = body["unit"] + " " + item.key;
      }
    }
    for (var item in combined.entries) {
      if (item.value == "description") {
        body["description"] = body["description"] + " " + item.key;
      }
    }
    for (var item in combined.entries) {
      if (item.value == "instructions") {
        body["instructions"] = body["instructions"] + " " + item.key;
      }
    }
    for (var item in combined.entries) {
      if (item.value == "ingredients") {
        body["ingredients"] = body["ingredients"] + " " + item.key;
      }
    }
    for (var item in combined.entries) {
      if (item.value == "preparationTime") {
        body["preparationTime"] = body["preparationTime"] + " " + item.key;
      }
    }
    for (var item in combined.entries) {
      if (item.value == "timeUnit") {
        body["timeUnit"] = body["timeUnit"] + " " + item.key;
      }
    }
    return body;
  }
}
