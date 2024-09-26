import 'package:flutter/material.dart';

class CityBottomSheet extends StatelessWidget {
  const CityBottomSheet({
    super.key,
    required this.cityController,
    required this.onAddCity,
  });

  final TextEditingController cityController;
  final Function(String) onAddCity;

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
          TextField(
            controller: cityController,
            decoration: const InputDecoration(
              labelText: 'Enter City Name',
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              final cityName = cityController.text;
              if (cityName.isNotEmpty) {
                onAddCity(cityName);
                Navigator.pop(context); // Close the BottomSheet
              }
            },
            child: const Text('Add City'),
          ),
        ],
      ),
    );
  }
}
