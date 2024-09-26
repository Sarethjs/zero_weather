import 'package:flutter/material.dart';
import 'package:zero_weather/components/city_card.dart';
import 'package:zero_weather/components/no_data.dart';
import 'package:zero_weather/models/city_inf.dart';

class CitiesPage extends StatelessWidget {
  const CitiesPage({super.key, required this.cities});

  // Cities
  final List<CityInf> cities;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cities.isEmpty // Verify if the list is empty
          ? const Center(child: NoData())
          : ListView.builder(
              itemCount: cities.length,
              itemBuilder: (context, index) {
                final city = cities[index]; // Accede al nombre de la ciudad
                return CityCard(
                  cityName: city.cityName,
                  description: city.description ?? 'Null',
                  time: city.formatTime(),
                  imageUrl: city.getIconUrl(),
                );
              },
            ),
    );
  }
}
