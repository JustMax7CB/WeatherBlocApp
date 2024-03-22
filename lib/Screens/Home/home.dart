import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Bloc/weather_bloc.dart';
import 'package:weather_app/Bloc/weather_event.dart';
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
          return const Scaffold(
            backgroundColor: Color(0xffb3d6f3),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is AutoCompleteSearchState) {
          return const Scaffold(
            backgroundColor: Color(0xffb3d6f3),
          );
        } else if (state is InitialWeatherState) {
          final weatherList = state.weatherData;
          return Scaffold(
            appBar: state.weatherData.isNotEmpty
                ? AppBar(
                    toolbarHeight: screenHeight(context) * 0.05,
                    backgroundColor: state.toUpdate
                        ? const Color(0xffb3a8f3)
                        : const Color(0xffb3d6f3),
                    title: state.toUpdate
                        ? const Text(
                            'Updating data...',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontStyle: FontStyle.italic),
                          )
                        : Text(
                            'Last update at: ${state.weatherData.first.timeToDisplay}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                    centerTitle: true,
                  )
                : null,
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
            body: SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    Flexible(
                      flex: 10,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: GestureDetector(
                          onVerticalDragDown: (_) {
                            context.read<WeatherBloc>().add(UpdateDataEvent());
                          },
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
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
                    ),
                  ],
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
