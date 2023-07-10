import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Student {
  int? id;
  String? name;
  String? email;
  UserDepartment? studentDepartment;
  Year? studentYear;

  Student({this.id, this.email, this.name, this.studentDepartment});
  factory Student.fromJson(Map<String, dynamic> json) {
    Student d = Student();
    d.id = json['id'];
    d.name = json['name'];
    d.email = json['email'];
    d.studentDepartment = UserDepartment.fromJson(json['department']);
    d.studentYear = Year.fromJson(json['year']);
    return d;
  }
}

class UserDepartment with ChangeNotifier {
  int? departmentId;
  String? departmentName;

  UserDepartment({this.departmentId, this.departmentName});
  factory UserDepartment.fromJson(Map<String, dynamic> json) {
    UserDepartment department = UserDepartment();
    department.departmentId = json['id'];
    department.departmentName = json['name'];

    return department;
  }
}

class Year {
  int? yearId;
  String? yearName;

  Year({this.yearId, this.yearName});
  factory Year.fromJson(Map<String, dynamic> json) {
    Year year = Year();
    year.yearId = json['id'];
    year.yearName = json['name'];
    return year;
  }
}
