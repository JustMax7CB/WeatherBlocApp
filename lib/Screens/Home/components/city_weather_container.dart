import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Bloc/weather_bloc.dart';
import 'package:weather_app/Bloc/weather_event.dart';

class CityWeatherContainer extends StatelessWidget {
  const CityWeatherContainer({
    required this.cityName,
    super.key,
    this.countryName,
    this.weatherIcon,
    this.temperature,
  });

  final String cityName;
  final String? countryName;
  final String? weatherIcon;
  final String? temperature;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(width: 1.6, color: Colors.black54),
      ),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$cityName, $countryName',
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            IconButton(
              icon: const Icon(
                size: 30,
                Icons.delete_forever,
                color: Color(0xc3c51d2b),
              ),
              onPressed: () => BlocProvider.of<WeatherBloc>(context)
                  .add(DeleteCityEvent(cityName: cityName)),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Text(
              '$temperature°C',
              style:
                  const TextStyle(fontSize: 40, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              child: weatherIcon != null
                  ? Image.network('http:$weatherIcon')
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
