import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:weather_app/API/Response/weather_response.dart';
import 'package:weather_app/API/weather_api.dart';
import 'package:weather_app/Utils/http_interceptor.dart';
import 'package:weather_app/Utils/logger.dart';
import 'package:weather_app/constants.dart';

@Injectable(as: WeatherAPI)
class WeatherAPIImpl extends WeatherAPI {

  WeatherAPIImpl(this._interceptor);
  final HttpInterceptor _interceptor;
  final Logger _logger = Logger(tag: 'WeatherAPI');

  Future<http.Response> sendRequest(http.BaseRequest request) async =>
       _interceptor.onRequest(request);

  @override
  Future<WeatherAPIResponse> getWeatherDataByCity({required String city}) async {
    final request =
        http.Request('GET', Uri.parse('$weatherApiBaseUrl?q=$city&key=$apiKey'));

    try {
      final response = await sendRequest(request);
      final responseData =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      _logger.info('Response data: $responseData');
      final weatherResponse = WeatherAPIResponse.fromJson(responseData);
      _logger.info('Weather model: $weatherResponse');
      return weatherResponse;

    } on SocketException catch (err) {
      _logger.error('Caught exception with error: ${err.osError}');
      return Future.error(err.osError.toString());

    } catch (e) {
      _logger.error(e.toString());
      return Future.error(e.toString());
    }
  }
}
