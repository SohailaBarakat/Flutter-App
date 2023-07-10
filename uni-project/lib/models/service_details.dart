import 'package:flutter/foundation.dart';

class ServiceId with ChangeNotifier {
  List<Data>? data;
  ServiceId({this.data});

  factory ServiceId.fromJson(Map<String, dynamic> json) {
    ServiceId serviceId = ServiceId();
    serviceId.data = [];
    for (var d in json['data']) {
      Data temp = Data.fromJson(d);
      serviceId.data!.add(temp);
    }
    return serviceId;
  }
}

class Data with ChangeNotifier {
  int? id;
  String? title;
  String? contentType;
  Null? content;
  int? priority;
  Department? department;
  Year? year;
  ServiceData? service;
  List<Attachments>? attachments;

  Data(
      {this.id,
      this.title,
      this.contentType,
      this.content,
      this.priority,
      this.department,
      this.year,
      this.service,
      this.attachments});

  factory Data.fromJson(Map<String, dynamic> json) {
    Data d = Data();
    d.id = json['id'];
    d.title = json['title'];
    d.contentType = json['content_type'];
    d.content = json['content'];
    d.priority = json['priority'];
    d.department = Department.fromJson(json['department']);
    d.year = Year.fromJson(json['year']);
    d.service = ServiceData.fromJson(json['service']);
    d.attachments = [];
    for (var s in json['attachments']) {
      Attachments temp = Attachments.fromJson(s);
      d.attachments!.add(temp);
    }
    return d;
  }
}

class Department {
  int? id;
  String? name;

  Department({this.id, this.name});

  factory Department.fromJson(Map<String, dynamic> json) {
    Department department = Department();
    department.id = json['id'];
    department.name = json['name'];
    return department;
  }
}

class Year {
  int? id;
  String? name;

  Year({this.id, this.name});
  factory Year.fromJson(Map<String, dynamic> json) {
    Year year = Year();
    year.id = json['id'];
    year.name = json['name'];
    return year;
  }
}

class ServiceData with ChangeNotifier {
  int? id;
  String? name;

  ServiceData({this.id, this.name});
  factory ServiceData.fromJson(Map<String, dynamic> json) {
    ServiceData serviceData = ServiceData();
    serviceData.id = json['id'];
    serviceData.name = json['name'];

    return serviceData;
  }
}

class Attachments with ChangeNotifier {
  String? name;
  String? type;
  String? path;

  Attachments({this.name, this.type, this.path});

  factory Attachments.fromJson(Map<String, dynamic> json) {
    Attachments attachments = Attachments();
    attachments.name = json['name'];
    attachments.type = json['type'];
    attachments.path = json['path'];
    return attachments;
  }
}
