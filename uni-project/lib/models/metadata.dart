import 'package:flutter/foundation.dart';

class MetaData with ChangeNotifier {
  String? token;

  MetaData({this.token});
  factory MetaData.fromJson(Map<String, dynamic> json) {
    MetaData t = MetaData();
    t.token = json['token'];

    return t;
  }
  notifyListeners();
}
