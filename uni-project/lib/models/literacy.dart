import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './literacy_form_data.dart';
import './error_data.dart';
import 'dart:convert';

class LiteracyForm with ChangeNotifier {
  String authToken;
  String message;
  LiteracyForm(this.authToken, this.message);

  Future<void> sendRequest(String name, String address, String illiterateId,
      String classroom, String classroomType) async {
    final url = Uri.parse('http://spsu.psu.edu.eg/api/submit_literacy');
    LiteracyMessage literacyMessage;
    Errors errors;
    final response = await http.post(url,
        headers: ({
          "Accept": "application/json",
          "Authorization": "Bearer $authToken"
        }),
        body: {
          'name': name,
          'address': address,
          'illiterate_id': illiterateId,
          'classroom': classroom,
          'classroom_type': classroomType
        });
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      literacyMessage = LiteracyMessage.fromJson(jsonData);
      message = literacyMessage.message!;
      inspect(message);
    } else if (response.statusCode == 422) {
      var jsonData = jsonDecode(response.body);
      errors = Errors.fromJson(jsonData);
      inspect(errors.data);
    }
    notifyListeners();
  }
}
