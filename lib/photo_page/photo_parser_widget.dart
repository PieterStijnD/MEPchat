import 'package:flutter/material.dart';
import 'package:new_base/api/api_recipes.dart';

class PhotoParserWidget extends StatefulWidget {
  final List<String> sentences;

  const PhotoParserWidget({required this.sentences});

  @override
  PhotoParserWidgetState createState() => PhotoParserWidgetState();
}

class PhotoParserWidgetState extends State<PhotoParserWidget> {
  List<String> sentences = [];

  @override
  initState() {
    super.initState();
    sentences = widget.sentences;
  }

  List<String> options = [
    "none",
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
    // List<String> sentences = ["sentence 1", "sentence 2", "sentence 3"];
    late List<String> selectedOptions =
        List.filled(sentences.length, options[0]);

    void _selectOption(String option, int index) {
      setState(() {
        selectedOptions[index] = option;
      });
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.sentences.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.sentences[index]),
                    DropdownButton<String>(
                      value: selectedOptions[index],
                      // onChanged: (String? newValue) {
                      //   setState(() {
                      //     selectedOptions[index] = newValue!;
                      //   });
                      // },
                      onChanged: (value) {
                        setState(() {
                          selectedOptions[index] = value!;
                        });
                      },
                      items: options
                          .map((String option) => DropdownMenuItem<String>(
                                value: option,
                                child: Text(option),
                              ))
                          .toList(),
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
    );
  }
}
