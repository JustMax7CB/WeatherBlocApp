import 'package:flutter/material.dart';

class CitySearchBar extends StatelessWidget {

  const CitySearchBar({required this.searchController, super.key});
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 45,
        maxHeight: 45,
      ),
      child: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.symmetric(horizontal: 25),
          fillColor: Colors.white60,
          filled: true,
          hintText: 'Search city',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(width: 0.4),
          ),
        ),
      ),
    );
  }
}
