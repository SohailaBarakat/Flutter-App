import 'package:flutter/foundation.dart';
import 'package:uni_project1/models/all_services.dart';

class MedicalClinicsService {
  List<ClinicData>? clinicData;
  MedicalClinicsService({this.clinicData});

  factory MedicalClinicsService.fromJson(Map<String, dynamic> json) {
    MedicalClinicsService medicalClinicsService = MedicalClinicsService();
    medicalClinicsService.clinicData = [];
    for (var c in json['data']) {
      ClinicData temp = ClinicData.fromJson(c);
      medicalClinicsService.clinicData!.add(temp);
    }
    return medicalClinicsService;
  }
}

class ClinicData {
  int? id;
  String? name;
  ClinicData({this.id, this.name});
  factory ClinicData.fromJson(Map<String, dynamic> json) {
    ClinicData c = ClinicData();
    c.id = json['id'];
    c.name = json['name'];
    return c;
  }
}
