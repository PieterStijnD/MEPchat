import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ApiData extends ChangeNotifier {
  String? apiKey = "";

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
    apiKey = newApiKey;
  }
}
