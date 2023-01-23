import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'api_general.dart';

Future<List<RecipeClass>> getRecipesFromServer(context) async {
  String startOfUrl = Provider.of<ApiData>(context, listen: false).getApiUrl();

  var url = Uri.parse('http://10.0.2.2:8081/recipe');

  String key = Provider.of<ApiData>(context, listen: false).apiKey!;

  var response = await http.get(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $key',
    },
  );

  var decodedData = jsonDecode(response.body);

  List<RecipeClass> list = [];
  for (var item in decodedData) {
    list.add(RecipeClass.fromJson(item));
  }
  return list;
}

Future<int> postRecipe(String title, context) async {
  String startOfUrl = Provider.of<ApiData>(context, listen: false).getApiUrl();

  var url = Uri.parse('http://10.0.2.2:8081/recipe');

  String key = Provider.of<ApiData>(context, listen: false).apiKey!;

  Map data = {
    "name": "recept",
    "volume": 500,
    "unit": {"name": "g"},
    "instructions": "Fork it over",
    "preparationTime": 600,
    "timeUnit": {"name": "uur"}
  };

  var body = json.encode(data);

  var response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $key',
    },
    body: body,
  );

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  return response.statusCode;
}

Future<int> deleteRecipe(int id, context) async {
  String startOfUrl = Provider.of<ApiData>(context, listen: false).getApiUrl();

  var url = Uri.parse('http://10.0.2.2:8081/recipe/$id');

  String key = Provider.of<ApiData>(context, listen: false).apiKey!;

  Map data = {
    "id": id,
  };

  var body = json.encode(data);

  var response = await http.delete(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $key',
    },
    body: body,
  );

  print('${response.statusCode}');
  print('${response.body}');
  return response.statusCode;
}

class RecipeClass {
  RecipeClass({
    this.id,
    this.enabled,
    this.name,
  });

  int? id;
  bool? enabled;
  String? name;

  factory RecipeClass.fromJson(Map<String, dynamic> json) => RecipeClass(
        id: json["id"],
        enabled: json["enabled"],
        name: json["name"],
      );
}
