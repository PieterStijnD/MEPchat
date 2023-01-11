import 'dart:convert';

import 'package:flutter/cupertino.dart';
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

Future<List<Item>> getMepLijstenFromServerAsListItems(context) async {
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
  //TODO improve logic, make more neat
  List<MepLijstData> list = [];
  for (var item in decodedData) {
    list.add(MepLijstData.fromJson(item));
  }
  List<Item> list2 = [];
  for (var item in list) {
    return List<Item>.generate(list.length, (int index) {
      return Item(
        isExpanded: false,
        isActive: true,
        headerValue: item.name!,
        expandedValue: 'This is item number $index',
      );
    });
  }

  return list2;
}

void deleteMepLijst(context) async {
  //TODO wait for implementation
  String startOfUrl = Provider.of<ApiData>(context, listen: false).getApiUrl();

  var url = Uri.parse('http://10.0.2.2:8081/delete/mep-lijst');

  String key = Provider.of<ApiData>(context, listen: false).apiKey!;

  var response = await http.get(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $key',
    },
  );

  debugPrint('${response.statusCode}');
}

class MepLijstData {
  MepLijstData({
    this.mep_id,
    this.enabled,
    this.name,
    // this.app_user_id,
  });

  int? mep_id;
  bool? enabled;
  String? name;

  // int? app_user_id;

  factory MepLijstData.fromJson(Map<String, dynamic> json) => MepLijstData(
        mep_id: json["mep_id"],
        enabled: json["enabled"],
        name: json["name"],
        // app_user_id: json["app_user_id"]
      );
}
