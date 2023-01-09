import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'api_general.dart';

Future<MepLijstData> getMepLijstenFromServer(int locationID, context) async {
  String startOfUrl = Provider.of<ApiData>(context, listen: false).getApiUrl();

  var url = Uri.parse('$startOfUrl/get/mep-lijst');

  var response = await http.get(url, headers: {
    "Content-Type": "application/json",
    "Authorization": Provider.of<ApiData>(context, listen: false).apiKey!,
  });

  var decodedData = jsonDecode(response.body);

  MepLijstData mepLijstData = MepLijstData.fromJson(decodedData);
  return mepLijstData;
}

class MepLijstData {
  MepLijstData({
    this.mep_id,
    this.enabled,
    this.name,
    this.app_user_id,
  });

  int? mep_id;
  bool? enabled;
  String? name;
  int? app_user_id;

  factory MepLijstData.fromJson(Map<String, dynamic> json) => MepLijstData(
      mep_id: json["mep_id"],
      enabled: json["enabled"],
      name: utf8.decode(json["name"]),
      app_user_id: json["app_user_id"]);
}
