import 'package:driver_app/base/base.dart';

class HomeProvider extends BaseProvider {

  int _currentIndex = 0;

  get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}