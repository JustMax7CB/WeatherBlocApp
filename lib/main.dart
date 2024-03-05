import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Bloc/weather_bloc.dart';
import 'package:weather_app/Bloc/weather_event.dart';
import 'package:weather_app/Injection/di.dart';
import 'package:weather_app/Screens/Home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  configureDependencies();
  runApp(
    BlocProvider(
      create: (context) => WeatherBloc(weatherRepository: weatherRepository)
        ..add(InitialLoadEvent()),
      child: const MaterialApp(
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
