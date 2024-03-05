import 'dart:convert';

import 'package:flutter/services.dart';
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
    on<StartAutocompleteSearchEvent>(_startAutocompleteSearch);
  }
  static List<String>? allCityNames;

  final WeatherRepository _weatherRepository;
  final Logger _logger = Logger(tag: 'WeatherBloc');

  static final List<WeatherModel> _weatherList = [];

  Future<void> loadCities() async {
    final response =
        await rootBundle.loadString('lib/assets/cities_names.json');
    final List<dynamic> data = await json.decode(response);
    allCityNames = data.cast<String>(); // Cast the list to a list of strings
  }

  Future<void> _startAutocompleteSearch(StartAutocompleteSearchEvent event,
      Emitter<WeatherBlocState> emit,) async {
    final searchedCityName = event.currentString;
    if (allCityNames == null) await loadCities();
    final relevantCities = allCityNames!
        .where((cityName) =>
            cityName.toLowerCase().startsWith(searchedCityName.toLowerCase()),)
        .toList();
    print(relevantCities);
    emit(AutoCompleteSearchState(cities: relevantCities));
  }

  Future<void> _fetchWeatherData(
    StartingFetchEvent event,
    Emitter<WeatherBlocState> emit,
  ) async {
    _logger.info('Starting Fetching Weather Data, cityName: ${event.city}');
    try {
      final weatherData =
          await _weatherRepository.getCityWeatherData(cityName: event.city);
      await _weatherRepository.saveCityWeatherData(weatherData: weatherData);
      _weatherList.add(weatherData);
      emit(InitialWeatherState(weatherData: _weatherList));
    } catch (e) {
      _logger.error(e.toString());
      emit(InitialWeatherState(weatherData: _weatherList));
    }
  }

  Future<void> _initialLoadWeather(
      InitialLoadEvent event, Emitter<WeatherBlocState> emit,) async {
    final weatherData = await _weatherRepository.getAllSavedWeatherData();
    _weatherList.addAll(weatherData);
    emit(InitialWeatherState(weatherData: _weatherList));
  }

  Future<void> _deleteCityWeatherData(
      DeleteCityEvent event, Emitter<WeatherBlocState> emit,) async {
    await _weatherRepository.deleteCityData(event.cityName);
    _weatherList.removeWhere((cityData) => cityData.name == event.cityName);
    emit(InitialWeatherState(weatherData: _weatherList));
  }
}
