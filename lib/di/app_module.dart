import 'package:dartin/dartin.dart';
import 'package:dio/dio.dart';
import 'package:driver_app/data/repository.dart';
import 'package:driver_app/utils/shared_preferences_utils.dart';
import 'package:driver_app/view/hone/home_provider.dart';

const testScope = DartInScope('test');

final viewModelModule = Module([
  factory<HomeProvider>(({params}) => HomeProvider(params.get(0), get())),
])
  ..addOthers(testScope, [
    ///other scope
//  factory<HomeProvide>(({params}) => HomeProvide(params.get(0), get<GithubRepo>())),
  ]);


final repoModule = Module([
  lazy<GithubRepo>(({params}) => GithubRepo(get(), get())),
]);

final remoteModule = Module([
  single<GithubService>(GithubService()),
]);

final localModule = Module([
  single<SpUtil>(spUtil),
]);

final appModule = [viewModelModule, repoModule, remoteModule, localModule];

class AuthInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) {
    final token = spUtil.getString("TOKEN");
    options.headers.update("Authorization", (_) => token, ifAbsent: () => token);
    return super.onRequest(options);
  }
}

final dio = Dio()
  ..options = BaseOptions(baseUrl: 'https://api.github.com/', connectTimeout: 30, receiveTimeout: 30)
  ..interceptors.add(AuthInterceptor())
  ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

SpUtil spUtil;

init() async {
  spUtil = await SpUtil.getInstance();
  startDartIn(appModule);
}