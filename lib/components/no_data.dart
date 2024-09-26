import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center, // Alineación a la izquierda
      children: [
        // Image from asset
        Image.asset(
          'assets/no_data.jpg',
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 10),

        const Text(
          'No data Found',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Segunda línea de texto
        const Text(
          'Please add a city to track its weather',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
