import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:zero_weather/services/city_service.dart';

class AutocompleteCity extends StatefulWidget {
  const AutocompleteCity({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<AutocompleteCity> createState() => _AutocompleteCityState();
}

class _AutocompleteCityState extends State<AutocompleteCity> {
  List<Map<String, dynamic>> cities = [];
  List<String> cityNames = <String>[];

  @override
  Widget build(BuildContext context) {
    return EasyAutocomplete(
      suggestions: cityNames,
      controller: widget.controller,
      onChanged: (value) async {
        // Fetch data from API
        // Llamar a la API
        final fetchedCities = await CityService.fetchCities(value);
        setState(() {
          cities = fetchedCities;
          cityNames =
              fetchedCities.map((city) => city['City'] as String).toList();
          print(cityNames);
        });
      },
      onSubmitted: (value) => print('onSubmitted value: $value'),
      decoration: InputDecoration(
        labelText: 'Add city',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.cancel_outlined),
          onPressed: () => widget.controller.clear(),
        ),
      ),
    );
  }
}
