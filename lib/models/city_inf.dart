import 'package:intl/intl.dart';

class CityInf {
  CityInf({
    required this.locationKey,
    required this.cityName,
    this.description,
  });

  final String locationKey;
  final String cityName;
  String? description;
  String? time;
  int? iconNumber;

  String getIconUrl() {
    if (iconNumber! < 10) {
      return 'https://developer.accuweather.com/sites/default/files/0$iconNumber-s.png';
    } else {
      return 'https://developer.accuweather.com/sites/default/files/$iconNumber-s.png';
    }
  }

  String formatTime() {
    DateTime dateTime = DateTime.parse(time!);
    // Formatting time
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    return formattedTime;
  }
}
