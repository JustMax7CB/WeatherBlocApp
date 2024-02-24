
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Bloc/weather_event.dart';
import 'package:weather_app/Bloc/weather_state.dart';
import 'package:weather_app/Model/weather_model.dart';
import 'package:weather_app/Repository/weather_repository.dart';
import 'package:weather_app/Utils/logger.dart';

class WeatherBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {

  WeatherBloc({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(LoadingWeatherState()) {
    on<StartingFetchEvent>(_fetchWeatherData);
    on<InitialLoadEvent>(_initialLoadWeather);
    on<DeleteCityEvent>(_deleteCityWeatherData);
  }
  final WeatherRepository _weatherRepository;
  final Logger _logger = Logger(tag: 'WeatherBloc');

  static final List<WeatherModel> _weatherList = [];

  Future<void> _fetchWeatherData(
      StartingFetchEvent event, Emitter<WeatherBlocState> emit,) async {
    _logger.info('Starting Fetching Weather Data, cityName: ${event.city}');
    final weatherData = await _weatherRepository.getCityWeatherData(cityName: event.city);
    await _weatherRepository.saveCityWeatherData(weatherData: weatherData);
    _weatherList.add(weatherData);
    emit(InitialWeatherState(weatherData: _weatherList));
  }

  Future<void> _initialLoadWeather(InitialLoadEvent event, Emitter<WeatherBlocState> emit) async {
    final weatherData = await _weatherRepository.getAllSavedWeatherData();
    _weatherList.addAll(weatherData);
    emit(InitialWeatherState(weatherData: _weatherList));
  }

  Future<void> _deleteCityWeatherData(DeleteCityEvent event, Emitter<WeatherBlocState> emit) async {
     await _weatherRepository.deleteCityData(event.cityName);
     _weatherList.removeWhere((cityData) => cityData.name == event.cityName);
     emit(InitialWeatherState(weatherData: _weatherList));

  }
}
