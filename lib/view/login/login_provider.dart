import 'package:dio/dio.dart';
import 'package:driver_app/base/base.dart';
import 'package:driver_app/data/repository.dart';
import 'package:rxdart/rxdart.dart';

class LoginProvider extends BaseProvider {
  final GithubRepo _repo;
  String userName = "";
  String password = "";
  bool _loading = false;
  bool _validateUserName = false;
  bool _validatePassword = false;
  String _response = "";
  final String title;

  double _btnWidth = 295.0;

  double get btnWidth => _btnWidth;

  set btnWidth(double btnWidth) {
    _btnWidth = btnWidth;
    notifyListeners();
  }


  bool get validateUserName => _validateUserName;

  set validateUserName(bool value) {
    _validateUserName = value;
  }

  String get response => _response;
  set response(String response) {
    _response = response;
    notifyListeners();
  }

  bool get loading => _loading;
  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  LoginProvider(this.title, this._repo);

  Observable login() => _repo
      .login(userName, password)
      .doOnData((r) => response = r.toString())
      .doOnError((e, stacktrace) {
        if (e is DioError) {
          response = e.response.data.toString();
        }
      })
      .doOnListen(() => loading = true)
      .doOnDone(() => loading = false);

  bool get validatePassword => _validatePassword;

  set validatePassword(bool value) {
    _validatePassword = value;
  }
}
