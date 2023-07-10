import 'package:flutter/foundation.dart';

class Errors {
  List<Data>? data;

  Errors({this.data});
  factory Errors.fromJson(Map<String, dynamic> json) {
    Errors errors = Errors();
    errors.data = [];
    for (var c in json['errors']) {
      Data temp = Data.fromJson(c);
      errors.data!.add(temp);
    }
    return errors;
  }
}

class Data {
  String? field;
  List<String>? message;

  Data({this.field, this.message});
  factory Data.fromJson(Map<String, dynamic> json) {
    Data d = Data();
    d.field = json['field'];
    d.message = json['message'].cast<String>();
    return d;
  }
}
