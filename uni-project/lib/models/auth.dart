import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
//ignore_for_file: prefer_const_constructors

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:uni_project1/models/http_exception.dart';
import './user_data.dart';
import './error_data.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import './user_response.dart';
import 'package:laravel_exception/laravel_exception.dart';

class Auth with ChangeNotifier {
  Student? studentData;
  String? message;
  List<String> _messages = [];
  List<String> get items {
    return [..._messages];
  }

  String? _token;
  bool get isAuth {
    return token != null;
  }

  dynamic get token {
    if (_token != null) {
      return _token!;
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse('http://spsu.psu.edu.eg/api/login');
    UserResponse userResponse;
    Errors errors;

    try {
      final response = await http.post(url, body: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        userResponse = UserResponse.fromJson(jsonData);
        studentData = userResponse.studentData!;

        inspect(userResponse);
        _token = userResponse.metaData!.token!;
        inspect(_token);
      } else if (response.statusCode != 200) {
        var jsonData = json.decode(response.body);
        errors = Errors.fromJson(jsonData);
        List<Data> errorData = errors.data!;
        for (var l in errorData) {
          var listOfMessages = l.message!;
          for (var m in listOfMessages) {
            message = listOfMessages[0];
          }
          inspect(message);
        }
        for (var c in errorData) {
          var errorField = c.field;

          throw HttpException(errorField!);
        }
      }
    } on SocketException {
      inspect('no internet');
      throw HttpException('internet');
    } on TimeoutException {
      throw HttpException('internet');
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    } else {
      final extractedUserData =
          json.decode(prefs.getString('userData') as String)
              as Map<String, dynamic>;
      if (extractedUserData['token'] == null) {
        return false;
      }
      _token = extractedUserData['token'] as String;
      studentData = extractedUserData['studentData'] as Student;
      notifyListeners();
    }

    return true;
  }

  void logout() {
    _token = null;
    studentData = null;
    notifyListeners();
  }
}
