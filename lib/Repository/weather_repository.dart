import 'package:injectable/injectable.dart';
import 'package:weather_app/API/weather_api.dart';
import 'package:weather_app/Database/weather_table_handler.dart';
import 'package:weather_app/Model/weather_model.dart';
import 'package:weather_app/Utils/logger.dart';

@injectable
class WeatherRepository {

  WeatherRepository({required WeatherAPI weatherAPI})
      : _weatherAPI = weatherAPI;
  final WeatherAPI _weatherAPI;
  final WeatherTableHandler _weatherTableHandler = WeatherTableHandler();
  final Logger _logger = Logger(tag: 'WeatherRepository');

  Future<WeatherModel> getCityWeatherData({required String cityName}) async {
    _logger.info('getCityWeatherData: $cityName');
    final weatherResponse =  await _weatherAPI.getWeatherDataByCity(city: cityName);
    return WeatherModel.fromAPI(weatherResponse);
  }

  Future<void> saveCityWeatherData({required WeatherModel weatherData}) async {
    _logger.info('saveCityWeatherData: $weatherData');
    await _weatherTableHandler.insertWeatherData(weatherData);
  }

  Future<List<WeatherModel>> getAllSavedWeatherData() async {
    _logger.info('getAllSavedWeatherData');
    final data = await _weatherTableHandler.getAllWeatherData();
    final weatherModelList = data.map(WeatherModel.fromMap).toList();
    return weatherModelList;
  }

  Future<List<String>> getAllSavedCities() async {
    _logger.info('getAllSavedCities');
    final data = await _weatherTableHandler.getSavedCities();
    return data;
  }

  Future<void> deleteCityData(String cityName) async {
    _logger.info('deleteCityData: $cityName');
    await _weatherTableHandler.deleteWeatherData(cityName);
  }
}
