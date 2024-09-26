import 'package:flutter/material.dart';
import 'package:zero_weather/components/bottom_bar.dart';
import 'package:zero_weather/components/city_bottom_sheet.dart';
import 'package:zero_weather/models/city_inf.dart';
import 'package:zero_weather/pages/cities_page.dart';
import 'package:zero_weather/services/city_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1;

  // My saved cities
  final List<CityInf> savedCities = [];

  // Add new city
  dynamic _addNewCity(CityInf newCity) async {
    // Get icon
    final responseMap =
        await CityService.fetchWeatherConditions(newCity.locationKey);

    print(responseMap);

    setState(() {
      newCity.time = responseMap['LocalObservationDateTime'];
      newCity.iconNumber = responseMap['WeatherIcon'];
      savedCities.add(newCity);
      print('City received ${newCity.cityName}');
    });
  }

  // Change between screens
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
          onSave: _addNewCity,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Pages
    final List<Widget> pages = [
      const Center(child: Text('Home')),
      CitiesPage(cities: savedCities),
      const Center(child: Text('Profile')),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 5,
        title: Row(
          children: [
            Image.asset(
              'assets/cloudy.png',
              height: 32,
              width: 32,
              fit: BoxFit.cover,
            ),
            const Text(
              'WeatherForemost',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: _openBottomSheet,
        backgroundColor: Colors.lightBlue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomBar(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
