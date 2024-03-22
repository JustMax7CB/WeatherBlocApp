import 'package:intl/intl.dart';
import 'package:weather_app/API/Response/weather_response.dart';

class WeatherModel {
  WeatherModel(
      {required this.name,
      required this.country,
      required this.tempC,
      required this.icon,
      this.timestamp,});

  factory WeatherModel.fromMap(Map<String, dynamic> json) => WeatherModel(
        name: json['city_name'],
        country: json['country_name'],
        tempC: json['temp_c'],
        icon: json['iconUrl'],
      );

  factory WeatherModel.fromAPI(WeatherAPIResponse weatherAPIResponse) =>
      WeatherModel(
          name: weatherAPIResponse.city,
          country: weatherAPIResponse.country,
          icon: weatherAPIResponse.icon,
          tempC: weatherAPIResponse.temp,
          timestamp: weatherAPIResponse.timestamp.toString(),);

  final String name;
  final String country;
  final double tempC;
  final String icon;
  final String? timestamp;

  Map<String, dynamic> get toMap => {
        'city_name': name,
        'country_name': country,
        'temp_c': tempC,
        'iconUrl': icon,
        'timestamp': timestamp,
      };
  
  String get timeToDisplay {
    final dateTime = DateTime.parse(timestamp!);
    final milliseconds = DateTime.fromMillisecondsSinceEpoch(dateTime.millisecondsSinceEpoch);
    return DateFormat('dd/MM/yyyy HH:mm').format(milliseconds);
  }

  @override
  String toString() {
    return 'WeatherModel [name: $name, country: $country, tempC: $tempC, icon: $icon]';
  }
}
