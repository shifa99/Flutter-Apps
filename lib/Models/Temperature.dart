import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Temperature with ChangeNotifier {
  Map<String, dynamic> _weatherData = {};

  Future<void> fetchAndSet(String city) async {
    final url =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=854a9547d5c7a0b926545ea61f689362&units=metric';
    try {
      final response = await http.get(url);
      final body = json.decode(response.body);
      _weatherData = {
        'city': city,
        'temp': body['main']['temp'],
        'max_tamp': body['main']['temp_max'],
        'min': body['main']['temp_min'],
        'humidity': body['main']['humidity'],
        'weatherState': body['weather'][0]['id'],
        'description': body['weather'][0]['description'],
      };
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Map<String, dynamic> get weatherData {
    return {..._weatherData};
  }
}
