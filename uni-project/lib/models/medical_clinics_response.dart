import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './medical_clinics.dart';
import './medical_form_data.dart';
import './error_data.dart';

class Clinics with ChangeNotifier {
  String authToken;
  String messagee;

  List<ClinicData> _clinicsData = [];
  Clinics(this._clinicsData, this.authToken, this.messagee);

  List<ClinicData> get data {
    return [..._clinicsData];
  }

  Future<void> fetchAndSetClinicData() async {
    final url =
        Uri.parse('https://students.codeideas.dev/api/medical_departments');
    MedicalClinicsService medicalClinicsService;
    try {
      final response = await http.get(url,
          headers: ({
            "Accept": "application/json",
            "Authorization": "Bearer $authToken",
          }));
      if (response.statusCode == 200) {
        var extractedData = json.decode(response.body);
        medicalClinicsService = MedicalClinicsService.fromJson(extractedData);
        _clinicsData = medicalClinicsService.clinicData!;
        // inspect(medicalClinicsService);
      } else {
        print('Request faild');
      }
    } on SocketException {
      print('Check your internet connection');
    } on FormatException {
      print('Problem retrieving data contact your admin');
    } catch (ex) {
      print('Error happend');
    }
    notifyListeners();
  }

  Future<void> sendReservation(
      String medical_department_id, String phone, String message) async {
    final url =
        Uri.parse('https://students.codeideas.dev/api/medical_reservations/');
    MedicalForm medicalForm;
    Errors errors;

    final response = await http.post(
      url,
      headers: ({
        "Accept": "application/json",
        "Authorization": "Bearer $authToken"
      }),
      body: {
        'medical_department_id': medical_department_id,
        'phone': phone,
        'message': message,
      },
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      medicalForm = MedicalForm.fromJson(jsonData);
      messagee = medicalForm.message!;
      inspect(messagee);
    } else if (response.statusCode == 422) {
      var jsonData = jsonDecode(response.body);
      errors = Errors.fromJson(jsonData);
      inspect(errors.data);
    }
    notifyListeners();
  }
}
