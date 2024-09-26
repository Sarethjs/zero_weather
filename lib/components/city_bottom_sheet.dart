import 'package:flutter/material.dart';

class CityBottomSheet extends StatelessWidget {
  const CityBottomSheet({
    super.key,
    required this.cityController,
    required this.onAddCity,
    required this.desController,
  });

  final TextEditingController cityController;
  final TextEditingController desController;
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
          // Type city name
          TextField(
            controller: cityController,
            decoration: InputDecoration(
              labelText: 'Add city',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  cityController.clear();
                },
                icon: const Icon(
                  Icons.cancel_outlined,
                  size: 30,
                ),
              ),
            ),
          ),

          // Just a blank space
          const SizedBox(height: 10),

          // Description
          TextField(
            controller: desController,
            minLines: 5,
            maxLines: 6,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),

          // Save city button
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
