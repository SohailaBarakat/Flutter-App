import 'package:flutter/foundation.dart';

class ServiceResponse {
  List<Service>? data;
  ServiceResponse({this.data});

  factory ServiceResponse.fromJason(Map<String, dynamic> json) {
    ServiceResponse serviceResponse = ServiceResponse();
    serviceResponse.data = [];
    for (var c in json['data']) {
      Service temp = Service.fromJson(c);
      serviceResponse.data!.add(temp);
    }
    return serviceResponse;
  }
}

class Service with ChangeNotifier {
  int? id;
  String? name;
  String? type;
  String? link;
  String? icon;

  Service({this.id, this.name, this.type, this.link, this.icon});
  factory Service.fromJson(Map<String, dynamic> json) {
    Service c = Service();
    c.id = json['id'];
    c.name = json['name'];
    c.type = json['type'];
    c.link = json['link'];
    c.icon = json['icon'];

    return c;
  }
}
