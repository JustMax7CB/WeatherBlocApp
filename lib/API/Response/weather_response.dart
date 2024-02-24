class WeatherAPIResponse {
  WeatherAPIResponse(
      {required this.city,
      required this.country,
      required this.temp,
      required this.icon,})
      : timestamp = DateTime.now();

  factory WeatherAPIResponse.fromJson(Map<String, dynamic> json) =>
      WeatherAPIResponse(
          city: json['location']['name'],
          country: json['location']['country'],
          temp: json['current']['temp_c'],
          icon: json['current']['condition']['icon'],);

  final String city;
  final String country;
  final double temp;
  final String icon;
  final DateTime timestamp;

  @override
  String toString() {
    return 'WeatherAPIResponse [city: $city, country: $country, temp: $temp, icon: $icon]';
  }
}
