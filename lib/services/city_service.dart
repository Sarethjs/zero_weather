import 'package:http/http.dart' as http;
import 'dart:convert';

class CityService {
  static String apiKey = 'wJwGLRxqkYBkS9Lri6ggeYQgCACBjs3K';
  static String baseUrl =
      'http://dataservice.accuweather.com/locations/v1/cities/autocomplete';

  static Future<List<Map<String, dynamic>>> fetchCities(String query) async {
    final url = Uri.parse('$baseUrl?apikey=$apiKey&q=$query');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Processing response
      List<Map<String, dynamic>> cityMatches = data.map((city) {
        return {
          'Key': city['Key'],
          'City': city['LocalizedName'],
          'Country': city['Country']['LocalizedName'],
        };
      }).toList();

      //print(cityMatches);

      return cityMatches;
    } else {
      throw Exception(response.body);
    }
  }

  // Nuevo método para obtener las condiciones actuales del clima
  static Future<Map<String, dynamic>> fetchWeatherConditions(
      String locationKey) async {
    const String tmpUrl =
        'http://dataservice.accuweather.com/currentconditions/v1/';
    final url = Uri.parse('$tmpUrl/$locationKey?apikey=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      if (data.isNotEmpty) {
        // Extracting data
        final weatherIcon = data[0]['WeatherIcon'];
        final observationDateTime = data[0]['LocalObservationDateTime'];

        // Return a map
        return {
          'WeatherIcon': weatherIcon,
          'LocalObservationDateTime': observationDateTime,
        };
      } else {
        throw Exception('No se encontraron datos para esta ubicación.');
      }
    } else {
      throw Exception('Error en la petición: ${response.statusCode}');
    }
  }
}
