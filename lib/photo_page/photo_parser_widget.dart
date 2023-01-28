import 'package:flutter/material.dart';
import 'package:new_base/api/api_recipes.dart';

class PhotoParserWidget extends StatefulWidget {
  final List<String> sentences;

  const PhotoParserWidget({required this.sentences});

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
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    int code = 0;
                    code = await postRecipe("title", context);
                    debugPrint(code.toString());
                    Navigator.pop(context);
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
}
