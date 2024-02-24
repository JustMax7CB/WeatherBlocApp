import 'package:weather_app/Model/weather_model.dart';

sealed class WeatherBlocState {}

class LoadingWeatherState extends WeatherBlocState {}

class InitialWeatherState extends WeatherBlocState {

  InitialWeatherState({required this.weatherData});
  final List<WeatherModel> weatherData;
}

class FetchedWeatherState extends WeatherBlocState {

  FetchedWeatherState({required this.data});
  final WeatherModel data;
}
