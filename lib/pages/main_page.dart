import 'package:flutter/material.dart';
import 'package:zero_weather/components/bottom_bar.dart';
import 'package:zero_weather/components/city_bottom_sheet.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text('Home')),
    const Center(child: Text('Cities')),
    const Center(child: Text('Profile')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Text City controller & desc controller
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _desController = TextEditingController();

  // Open Bottomsheet
  void _openBottomSheet() {
    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return CityBottomSheet(
          cityController: _cityController,
          desController: _desController,
          onAddCity: (cityName) {},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 5,
        title: const Row(
          children: [
            Icon(Icons.cloudy_snowing),
            Text(
              'WeatherForemost',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: _openBottomSheet,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomBar(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
