// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../API/weather_api.dart' as _i5;
import '../API/weather_api_impl.dart' as _i6;
import '../Database/db_manager.dart' as _i3;
import '../Repository/weather_repository.dart' as _i7;
import '../Utils/http_interceptor.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.DbManager>(_i3.DbManager());
    gh.factory<_i4.HttpInterceptor>(() => _i4.HttpInterceptor());
    gh.factory<_i5.WeatherAPI>(
        () => _i6.WeatherAPIImpl(gh<_i4.HttpInterceptor>()));
    gh.factory<_i7.WeatherRepository>(
        () => _i7.WeatherRepository(weatherAPI: gh<_i5.WeatherAPI>()));
    return this;
  }
}
