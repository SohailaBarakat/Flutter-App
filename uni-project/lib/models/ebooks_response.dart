import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import './ebooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Books with ChangeNotifier {
  String authToken;
  List<Book> _items = [];
  Books(this._items, this.authToken);

  List<Book> get items {
    return [..._items];
  }

  Future<void> fetchAndSetBooks() async {
    final url = Uri.parse('http://spsu.psu.edu.eg/api/e_books');
    EBooks eBooks;
    final response = await http.get(url,
        headers: ({
          "Accept": "application/json",
          "Authorization": "Bearer $authToken",
        }));
    if (response.statusCode == 200) {
      var extractedData = json.decode(response.body);
      eBooks = EBooks.fromJson(extractedData);
      _items = eBooks.data!;
      inspect(eBooks);
    }
    notifyListeners();
  }
}
