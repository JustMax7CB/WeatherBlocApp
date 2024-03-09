import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Bloc/weather_bloc.dart';
import 'package:weather_app/Bloc/weather_state.dart';
import 'package:weather_app/Screens/Home/components/city_weather_container.dart';
import 'package:weather_app/Screens/Home/search_dialog.dart';
import 'package:weather_app/Utils/screen_size_mixin.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with ScreenSizeMixin {
  final formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherBlocState>(
      builder: (context, state) {
        if (state is LoadingWeatherState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AutoCompleteSearchState) {
          return const Scaffold(
            backgroundColor: Color(0xffb3d6f3),
          );
        } else if (state is InitialWeatherState) {
          final weatherList = state.weatherData;
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              elevation: 0,
              backgroundColor: const Color(0xc07abef6),
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => const SearchDialog(),
                );
              },
              child: const Icon(Icons.add),
            ),
            backgroundColor: const Color(0xffb3d6f3),
            body: SafeArea(
              child: SizedBox.expand(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    children: [
                      Flexible(
                        flex: 10,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: weatherList.length,
                            itemBuilder: (context, index) {
                              return CityWeatherContainer(
                                cityName: weatherList[index].name,
                                countryName: weatherList[index].country,
                                temperature:
                                    weatherList[index].tempC.toString(),
                                weatherIcon: weatherList[index].icon,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
