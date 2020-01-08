import 'package:driver_app/data/model/user_model.dart';

class UserResponse {

  List<User> list;

  UserResponse(this.list);

  UserResponse.fromJson(Map<String, dynamic> json)
      : list = (json as List).map((i) => new User.fromJson(i)).toList();
}