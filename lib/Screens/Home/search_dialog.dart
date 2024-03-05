import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Bloc/weather_bloc.dart';
import 'package:weather_app/Bloc/weather_event.dart';
import 'package:weather_app/Bloc/weather_state.dart';
import 'package:weather_app/Screens/Home/components/city_search_bar.dart';
import 'package:weather_app/Utils/screen_size_mixin.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({super.key});

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> with ScreenSizeMixin {
  final _searchController = TextEditingController();

  void onChange(String cityString) {
    BlocProvider.of<WeatherBloc>(context)
        .add(StartAutocompleteSearchEvent(currentString: cityString));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WeatherBloc>();
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: screenHeight(context) * 0.8,
          minHeight: screenHeight(context) * 0.2,
          minWidth: screenWidth(context) * 0.95,
          maxWidth: screenWidth(context) * 0.95,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: ListView(
            children: [
              CitySearchBar(
                searchController: _searchController,
                onChangeCallback: onChange,
              ),
              BlocBuilder<WeatherBloc, WeatherBlocState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is AutoCompleteSearchState) {
                    return SizedBox(
                      width: screenWidth(context) * 0.9,
                      height: screenHeight(context) * 0.4,
                      child: ListView.builder(
                        itemCount: state.cities.length,
                        itemBuilder: (context, index) {
                          if (state.cities.isNotEmpty) {
                            final cityName = state.cities[index];
                            return GestureDetector(
                              onTap: () {
                                bloc.add(
                                  StartingFetchEvent(
                                    city: cityName,
                                  ),
                                );
                                Navigator.of(context).pop();
                              },
                              child: ListTile(
                                subtitle: Text(cityName),
                              ),
                            );
                          }
                          return null;
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
