import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../meplijst/mep_lijst_widget.dart';
import 'api_general.dart';

Future<List<MepLijstData>> getMepLijstenFromServer(context) async {
  String startOfUrl = Provider.of<ApiData>(context, listen: false).getApiUrl();

  var url = Uri.parse('http://10.0.2.2:8081/mep-lijst');

  String key = Provider.of<ApiData>(context, listen: false).apiKey!;

  var response = await http.get(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $key',
    },
  );

  var decodedData = jsonDecode(response.body);

  List<MepLijstData> list = [];
  for (var item in decodedData) {
    list.add(MepLijstData.fromJson(item));
  }
  return list;
}

Future<List<MepListClass>> getMepLijstenFromServerAsListItems(context) async {
  String startOfUrl = Provider.of<ApiData>(context, listen: false).getApiUrl();

  var url = Uri.parse('http://10.0.2.2:8081/mep-lijst');

  String key = Provider.of<ApiData>(context, listen: false).apiKey!;

  var response = await http.get(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $key',
    },
  );

  List decodedData = jsonDecode(response.body);

  List<MepLijstData> list = [];

  for (var item in decodedData) {
    list.add(MepLijstData.fromJson(item));
  }
  List<MepListClass> list2 = list
      .map((e) =>
          MepListClass(id: e.id!, isActive: e.enabled!, headerValue: e.name!))
      .toList();

  return list2;
}

Future<int> postMepLijst(String title, context) async {
  //TODO wait for implementation
  String startOfUrl = Provider.of<ApiData>(context, listen: false).getApiUrl();

  var url = Uri.parse('http://10.0.2.2:8081/mep-lijst');

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

Future<int> deleteMepLijst(int id, context) async {
  String startOfUrl = Provider.of<ApiData>(context, listen: false).getApiUrl();

  var url = Uri.parse('http://10.0.2.2:8081/mep-lijst/$id');

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

Future<int> switchEnabledMepLijst(bool isEnabled, int id, context) async {
  String startOfUrl = Provider.of<ApiData>(context, listen: false).getApiUrl();

  var url = Uri.parse('http://10.0.2.2:8081/mep-lijst/$id');

  String key = Provider.of<ApiData>(context, listen: false).apiKey!;

  List data = [
    {"op": "replace", "path": "/enabled", "value": !isEnabled}
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

  print('${response.statusCode}');
  print('${response.body}');
  return response.statusCode;
}

class MepLijstData {
  MepLijstData({
    this.id,
    this.enabled,
    this.name,
  });

  int? id;
  bool? enabled;
  String? name;

  factory MepLijstData.fromJson(Map<String, dynamic> json) => MepLijstData(
        id: json["id"],
        enabled: json["enabled"],
        name: json["name"],
      );
}
