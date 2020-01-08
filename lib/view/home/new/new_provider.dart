import 'package:dio/dio.dart';
import 'package:driver_app/base/base.dart';
import 'package:driver_app/data/model/user_model.dart';
import 'package:driver_app/data/model/user_response.dart';
import 'package:driver_app/data/repository.dart';
import 'package:rxdart/rxdart.dart';

class NewProvider extends BaseProvider {

  final GithubRepo _repo;
  bool _loading = false;
  List<User> _response;

  NewProvider(this._repo);

  List<User> get response => _response;
  set response(List<User> response) {
    _response = response;
    notifyListeners();
  }

  bool get loading => _loading;
  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  Observable<UserResponse> getUsers() => _repo
      .getUsers()
      .doOnData((r) => response = r.list)
      .doOnError((e, stacktrace) {
        if (e is DioError) {
          response = null;
        }
      })
      .doOnListen(() => loading = true)
      .doOnDone(() => loading = false);

}