import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Slidable(
        key: Key(cityName),
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          dismissible: DismissiblePane(
            onDismissed: () {
              BlocProvider.of<WeatherBloc>(context)
                  .add(DeleteCityEvent(cityName: cityName));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  showCloseIcon: true,
                  content: Text('Deleted $cityName weather data '),
                ),
              );
            },
          ),
          children: [
            SlidableAction(
              onPressed: (context) => BlocProvider.of<WeatherBloc>(context)
                  .add(DeleteCityEvent(cityName: cityName)),
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
            ),
            SlidableAction(
              onPressed: (_) {
                Share.share(
                  '$cityName, $countryName weather data:\nTemperature: $temperature°C',
                );
              },
              backgroundColor: const Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.share,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: 20,
              child: Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffacbaf5),
                      Color(0xff6aa6d0),
                      Color(0xff5c83c5),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 90,
                    sigmaY: 10,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 1),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1FEFF).withOpacity(0.15),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(width: 1.6, color: Colors.black54),
                    ),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              softWrap: true,
                              maxLines: 2,
                              '$cityName, $countryName',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            '$temperature°C',
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                            child: weatherIcon != null
                                ? Image.network('http:$weatherIcon')
                                : Container(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
