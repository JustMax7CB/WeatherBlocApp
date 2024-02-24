import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/Injection/di.config.dart';
import 'package:weather_app/Repository/weather_repository.dart';

final getIt = GetIt.instance;

@InjectableInit(
    initializerName: 'init', preferRelativeImports: true, asExtension: true,)
void configureDependencies() => getIt.init();

WeatherRepository get weatherRepository => getIt<WeatherRepository>();
