import './metadata.dart';
import './user_data.dart';

import 'metadata.dart';
import 'user_data.dart';

class UserResponse {
  MetaData? metaData;
  Student? studentData;
  UserResponse({this.metaData, this.studentData});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    UserResponse userResponse = UserResponse();
    userResponse.studentData = Student.fromJson(json['data']);
    userResponse.metaData = MetaData.fromJson(json['meta']);

    return userResponse;
  }
}
