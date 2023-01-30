import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ApiData extends ChangeNotifier {
  String? apiKey = "";
  String userName = "";

  String getApiUrl() {
    //TODO change to real url
    String url =
        Platform.isAndroid ? 'http://10.0.2.2:8081' : 'http://localhost:8081';
    return url;
  }

  String? getApiKey() {
    return apiKey;
  }

  void updateApiKey(String newApiKey) {
    // parse string before and after slash
    String apiKeyParsed = newApiKey.split("/")[0];
    String userNameParsed = newApiKey.split("/")[1];
    apiKey = apiKeyParsed;
    userName = userNameParsed;
  }

  String? getUserName() {
    return userName;
  }

  void updateUserName(String newUserName) {
    userName = newUserName;
  }
}
