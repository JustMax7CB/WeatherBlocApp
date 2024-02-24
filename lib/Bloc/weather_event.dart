sealed class WeatherBlocEvent {}

class InitialLoadEvent extends WeatherBlocEvent {}

class StartingFetchEvent extends WeatherBlocEvent {

  StartingFetchEvent({required this.city});
  final String city;
}

class DeleteCityEvent extends WeatherBlocEvent {

  DeleteCityEvent({required this.cityName});
  final String cityName;
}
