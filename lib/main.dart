import 'package:flutter/material.dart';
import 'package:weather_app/Models/Temperature.dart';
import 'package:weather_app/Screens/City.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Screens/DetailsWeather.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Temperature>(
      create: (context) => Temperature(),
      child: MaterialApp(
        routes: {
          DetailsWeather.routeName: (context) => DetailsWeather(),
        },
        home: City(),
      ),
    );
  }
}
