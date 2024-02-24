import 'package:weather_app/API/Response/weather_response.dart';

abstract class WeatherAPI {
  Future<WeatherAPIResponse> getWeatherDataByCity({required String city});
}
