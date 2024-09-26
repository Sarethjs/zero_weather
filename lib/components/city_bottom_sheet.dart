import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:zero_weather/models/city_inf.dart';
import 'package:zero_weather/services/city_service.dart';

class CityBottomSheet extends StatefulWidget {
  const CityBottomSheet({
    super.key,
    required this.cityController,
    required this.desController,
    required this.onSave,
  });

  final TextEditingController cityController;
  final TextEditingController desController;
  final Function(CityInf) onSave;

  @override
  State<CityBottomSheet> createState() => _CityBottomSheetState();
}

class _CityBottomSheetState extends State<CityBottomSheet> {
  List<Map<String, dynamic>> cities = [];
  List<String> cityNames = <String>[];

  CityInf selectedCity = CityInf(locationKey: 'Def', cityName: 'Def');

  void saveCity() {
    final cityName = widget.cityController.text;

    // Search selected city
    for (var city in cities) {
      if (city['City'] as String == cityName) {
        selectedCity = CityInf(
            locationKey: city['Key'],
            cityName: cityName,
            description: widget.desController.text);
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Autocomplete for city name
          EasyAutocomplete(
            suggestions: cityNames,
            controller: widget.cityController,
            onChanged: (value) async {
              // Fetch data from API
              // Call to API
              final fetchedCities = await CityService.fetchCities(value);
              setState(() {
                cities = fetchedCities;
                cityNames = fetchedCities
                    .map((city) => city['City'] as String)
                    .toList();
              });
            },
            decoration: InputDecoration(
              labelText: 'Add city',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.cancel_outlined),
                onPressed: () => widget.cityController.clear(),
              ),
            ),
          ),

          // Just a blank space
          const SizedBox(height: 10),

          // Description
          TextField(
            controller: widget.desController,
            minLines: 5,
            maxLines: 6,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),

          // Save city button
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () async {
                saveCity();
                widget.onSave(selectedCity);
                Navigator.pop(context, selectedCity);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                disabledBackgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Save City'),
            ),
          ),
        ],
      ),
    );
  }
}
