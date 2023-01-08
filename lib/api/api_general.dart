import 'package:flutter/foundation.dart';

class ApiData extends ChangeNotifier {
  String? apiKey = "empty";

  void updateKey(String? newKey) {
    apiKey = newKey;
    notifyListeners();
  }

  String getApiUrl() {
    //TODO change to real url
    return 'http://localhost:8080/register';
  }

  String? getApiKey() {
    return apiKey;
  }

  void updateApiKey(String apiKey) {
    apiKey = apiKey;
    notifyListeners();
  }
}
