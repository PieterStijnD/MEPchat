import 'package:new_base/common/recipe_parser.dart';

Map makeBodyForPost(
    List<String> sentences, List<String> selectedDropDownButton) {
  Map<String, String> combined = {
    for (var i = 0; i < sentences.length; i++)
      sentences[i]: selectedDropDownButton[i]
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
      List<String> parsedIngredient = ingredientParser(item.key);
      body["ingredients"] = body["ingredients"] + parsedIngredient;
      print("BIG FUCKING X");
      print(body["ingredients"]);
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
