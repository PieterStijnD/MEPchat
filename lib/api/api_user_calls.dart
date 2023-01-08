import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'api_general.dart';

void logOutUser(context) async {
  //TODO send delete request to server
  // final startOfUrl = Provider.of<ApiData>(context, listen: false).getApiUrl();
  //
  // var url = Uri.parse('$startOfUrl/api/user/current');
  //
  // var response = await http.delete(url, headers: {
  //   "ContentType": "application/json",
  //   "AUTHORIZATION": Provider
  //       .of<ApiData>(context, listen: false)
  //       .apiKey!
  // });

  Provider.of<ApiData>(context, listen: false).updateApiKey("empty");
}

Future<List> loginUser(context, name, password) async {
  // final startOfUrl = Provider.of<ApiData>(context, listen: false).getApiUrl();

  //TODO change to "real" address
  String url =
      Platform.isAndroid ? 'http://10.0.2.2:8081' : 'http://localhost:8081';
  var urlParsed = Uri.parse('$url/login');

  Map data = {
    "username": name,
    "password": password,
  };

  var body = json.encode(data);

  debugPrint("awaiting response");
  var response = await http.post(
    urlParsed,
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  debugPrint("received response: ${response.statusCode}");
  debugPrint("body:");
  debugPrint(response.body.toString());

  //TODO receive key and update
  String apiKey = response.body.toString();
  var list = [apiKey, response.statusCode];

  return list;
}

Future<int> registerUser(name, password, email, phone) async {
  // final startOfUrl = Provider.of<ApiData>(context, listen: false).getApiUrl();

  //TODO change to "real" address
  String url =
      Platform.isAndroid ? 'http://10.0.2.2:8081' : 'http://localhost:8081';
  var urlParsed = Uri.parse('$url/register');

  Map data = {
    "username": name,
    "password": password,
    "email": email,
    "phone": phone,
  };

  var body = json.encode(data);

  debugPrint("awaiting response");
  var response = await http.post(
    urlParsed,
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  debugPrint("received response: ${response.statusCode}");

  // Map<String, dynamic> temp = json.decode(response.body);

  //TODO receive key and update
  // String? apiKey = temp['api_key'];
  // Provider.of<ApiData>(context, listen: false).updateKey(apiKey);

  return response.statusCode;
}

Future<int> resetUser(name) async {
  // final startOfUrl = Provider.of<ApiData>(context, listen: false).getApiUrl();

  //TODO change to "real" address
  String url =
      Platform.isAndroid ? 'http://10.0.2.2:8081' : 'http://localhost:8081';
  var urlParsed = Uri.parse('$url/register');

  Map data = {
    "username": name,
  };

  var body = json.encode(data);
  //TODO create in backend, then test
  debugPrint("awaiting response");
  var response = await http.post(
    urlParsed,
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  debugPrint("received response: ${response.statusCode}");

  return response.statusCode;
}
