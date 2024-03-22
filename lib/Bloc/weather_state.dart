import 'package:weather_app/Model/weather_model.dart';

sealed class WeatherBlocState {}

class LoadingWeatherState extends WeatherBlocState {}

class InitialWeatherState extends WeatherBlocState {
  InitialWeatherState({required this.weatherData, this.toUpdate = false});

  final List<WeatherModel> weatherData;
  final bool toUpdate;
}

class UpdatingDataState extends WeatherBlocState {
  UpdatingDataState();
}

class AutoCompleteSearchState extends WeatherBlocState {
  AutoCompleteSearchState({required this.cities});

  final List<String> cities;
}

class FetchedWeatherState extends WeatherBlocState {
  FetchedWeatherState({required this.data});

  final WeatherModel data;
}
