import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'api_general.dart';

Future<List<MenuClass>> getMenusFromServer(context) async {
  String startOfUrl = Provider.of<ApiData>(context, listen: false).getApiUrl();

  var url = Uri.parse('http://10.0.2.2:8081/menucard');

  String key = Provider.of<ApiData>(context, listen: false).apiKey!;

  var response = await http.get(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $key',
    },
  );

  var decodedData = jsonDecode(response.body);

  List<MenuClass> list = [];
  for (var item in decodedData) {
    list.add(MenuClass.fromJson(item));
  }
  return list;
}

Future<int> postMenu(String title, context) async {
  String startOfUrl = Provider.of<ApiData>(context, listen: false).getApiUrl();

  var url = Uri.parse('http://10.0.2.2:8081/menucard');

  String key = Provider.of<ApiData>(context, listen: false).apiKey!;

  Map data = {
    "name": title,
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

Future<int> deleteMenu(int id, context) async {
  String startOfUrl = Provider.of<ApiData>(context, listen: false).getApiUrl();

  var url = Uri.parse('http://10.0.2.2:8081/menucard/$id');

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

Future<int> switchArchivedMenuLijst(bool isArchived, int id, context) async {
  String startOfUrl = Provider.of<ApiData>(context, listen: false).getApiUrl();

  var url = Uri.parse('http://10.0.2.2:8081/menucard/archiving/$id');

  String key = Provider.of<ApiData>(context, listen: false).apiKey!;

  List data = [
    {"op": "replace", "path": "/enabled", "value": !isArchived}
  ];

  var body = json.encode(data);

  var response = await http.patch(
    url,
    headers: {
      "Content-Type": "application/json-patch+json",
      "Authorization": 'Bearer $key',
    },
    body: body,
  );

  return response.statusCode;
}

class MenuClass {
  MenuClass({
    this.id,
    this.archived,
    this.name,
  });

  int? id;
  bool? archived;
  String? name;

  factory MenuClass.fromJson(Map<String, dynamic> json) => MenuClass(
        id: json["id"],
        archived: json["archived"],
        name: json["name"],
      );
}
