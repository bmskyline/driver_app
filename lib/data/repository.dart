import 'dart:convert';

import 'package:driver_app/data/model/user_model.dart';
import 'package:driver_app/data/model/user_response.dart';
import 'package:driver_app/utils/network_utils.dart';
import 'package:driver_app/utils/shared_preferences_utils.dart';
import 'package:rxdart/rxdart.dart';

class GithubService {
  Observable login() => get("user");
  Observable<UserResponse> getUsers() => get("users");
}

class GithubRepo {

  final GithubService _remote;
  final SpUtil _spUtil;


  GithubRepo(this._remote, this._spUtil);

  Observable login(String username, String password) {
    _spUtil.putString("TOKEN", "basic " + base64Encode(utf8.encode('$username:$password')));
    return _remote.login();
  }

  Observable<UserResponse> getUsers() {
    return _remote.getUsers();
  }
}