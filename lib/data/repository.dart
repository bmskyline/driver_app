import 'dart:convert';

import 'package:driver_app/utils/network_utils.dart';
import 'package:driver_app/utils/shared_preferences_utils.dart';
import 'package:rxdart/rxdart.dart';

class GithubService {
  Observable login() => get("user");
}

class GithubRepo {

  final GithubService _remote;
  final SpUtil _spUtil;


  GithubRepo(this._remote, this._spUtil);

  Observable login(String username, String password) {
    _spUtil.putString("TOKEN", "basic " + base64Encode(utf8.encode('$username:$password')));
    return _remote.login();
  }
}