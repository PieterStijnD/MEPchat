import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'api_general.dart';

Future<List<MepLijstData>> getMepLijstenFromServer(context) async {
  String startOfUrl = Provider.of<ApiData>(context, listen: false).getApiUrl();

  var url = Uri.parse('http://10.0.2.2:8081/get/mep-lijst');

  String key = Provider.of<ApiData>(context, listen: false).apiKey!;

  var response = await http.get(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $key',
    },
  );

  var decodedData = jsonDecode(response.body);

  print("decoded data: $decodedData");

  List<MepLijstData> list = [];
  for (var item in decodedData) {
    list.add(MepLijstData.fromJson(item));
  }
  print("list $list");
  return list;
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
