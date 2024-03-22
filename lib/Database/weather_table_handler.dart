import 'package:weather_app/Database/db_manager.dart';
import 'package:weather_app/Model/weather_model.dart';
import 'package:weather_app/Utils/logger.dart';

class WeatherTableHandler {
  final DbManager dbManager = DbManager();
  final Logger _logger = Logger(tag: 'WeatherTableHandler');

  Future<void> insertWeatherData(WeatherModel weatherData) async {
    _logger.debug('insertWeatherData: $weatherData');
    await dbManager.insertData(weatherData.toMap);
  }

  Future<void> updateWeatherData(WeatherModel weatherData) async {
    _logger.debug('updateWeatherData: $weatherData');
    await dbManager.updateData(weatherData.toMap, weatherData.name);
  }

  Future<void> deleteWeatherData(String cityName) async {
    _logger.debug('deleteWeatherData: $cityName');
    await dbManager.deleteData(cityName);
  }

  Future<List<Map<String, dynamic>>> getAllWeatherData() async {
    _logger.debug('getAllWeatherData');
    final allData = await dbManager.getAllData();
    _logger.debug('getAllWeatherData result: $allData');
    return allData;
  }

  Future<List<String>> getSavedCities() async {
    _logger.debug('getSavedCities');
    final savedCities = await dbManager.getOneColumnData(DbManager.columnName);
    _logger.debug('getSavedCities result: $savedCities');
    return savedCities.map((e) => e.values.first as String).toList();
  }
}
