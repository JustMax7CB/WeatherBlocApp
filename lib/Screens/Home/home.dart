import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Bloc/weather_bloc.dart';
import 'package:weather_app/Bloc/weather_event.dart';
import 'package:weather_app/Bloc/weather_state.dart';
import 'package:weather_app/Screens/Home/components/city_weather_container.dart';
import 'package:weather_app/Screens/Home/components/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityNameController = TextEditingController();
  final formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherBlocState>(
      builder: (context, state) {
        if (state is LoadingWeatherState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is InitialWeatherState) {
          final weatherList = state.weatherData;
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xcf77b3d0),
              onPressed: () {
                BlocProvider.of<WeatherBloc>(context)
                 .add(StartingFetchEvent(city: 'Tel Aviv'));
                _cityNameController.clear();
              },
              child: const Icon(Icons.add),
            ),
            backgroundColor: const Color(0xff98c8e0),
            body: SafeArea(
              child: SizedBox.expand(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Flexible(
                        child: Form(
                            key: formState,
                            child: CitySearchBar(
                              searchController: _cityNameController,
                            ),),
                      ),
                      Flexible(
                        flex: 10,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
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
