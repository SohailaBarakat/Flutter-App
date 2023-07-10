import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'all_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Services with ChangeNotifier {
  String authToken;
  // get id {}

  List<Service> _items = [];

  Services(this._items, this.authToken);

  List<Service> get items {
    return [..._items];
  }

  Future<void> fetchAndSetServices() async {
    final url = Uri.parse('http://spsu.psu.edu.eg/api/services');
    ServiceResponse serviceResponse;
    try {
      final response = await http.get(url,
          headers: ({
            "Accept": "application/json",
            "Authorization": "Bearer $authToken",
          }));
      if (response.statusCode == 200) {
        var extractedData = json.decode(response.body);
        serviceResponse = ServiceResponse.fromJason(extractedData);
        _items = serviceResponse.data!;
        inspect(serviceResponse);
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
}
