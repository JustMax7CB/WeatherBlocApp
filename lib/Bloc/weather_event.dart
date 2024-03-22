sealed class WeatherBlocEvent {}

class InitialLoadEvent extends WeatherBlocEvent {}

class StartingFetchEvent extends WeatherBlocEvent {
  StartingFetchEvent({required this.city});

  final String city;
}

class UpdateDataEvent extends WeatherBlocEvent {
  UpdateDataEvent();
}

class StartAutocompleteSearchEvent extends WeatherBlocEvent {

  StartAutocompleteSearchEvent({required this.currentString});
  final String currentString;
}

class DeleteCityEvent extends WeatherBlocEvent {
  DeleteCityEvent({required this.cityName});

  final String cityName;
}
