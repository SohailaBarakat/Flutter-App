import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './all_services.dart';
import './all_services_response.dart';
import 'service_details.dart';
import 'dart:convert';

class ServiceDetails with ChangeNotifier {
  String authToken;

  List<Data> _details = [];

  ServiceDetails(this._details, this.authToken);

  List<Data> get details {
    return [..._details];
  }

  Future<void> fetchAndSetDetails(sId) async {
    final url = Uri.parse('http://spsu.psu.edu.eg/api/services/$sId');
    ServiceId serviceId;
    try {
      final response = await http.get(url,
          headers: ({
            "Accept": "application/json",
            "Authorization": "Bearer $authToken",
          }));
      if (response.statusCode == 200) {
        var extractedData = json.decode(response.body);
        serviceId = ServiceId.fromJson(extractedData);
        _details = serviceId.data!;

        // inspect(_details);
      }
    } catch (ex) {
      print('Error happend');
    }

    notifyListeners();
  }
}
