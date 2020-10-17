import 'package:flutter/material.dart';
import 'package:weather_app/Models/Temperature.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Models/Service.dart';

class DetailsWeather extends StatelessWidget {
  static String routeName = 'DetailsWeather';
  final kStyle = TextStyle(fontSize: 23, fontWeight: FontWeight.w700);
  @override
  Widget build(BuildContext context) {
    final weatherData =
        Provider.of<Temperature>(context, listen: false).weatherData;
    final deviceSize = MediaQuery.of(context).size;
    Service service = Service();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(weatherData['city'] + ' Weather'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.cyan, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 140,
                child: Image.asset(
                  'images/' +
                      service.getImage(weatherData['weatherState']) +
                      '.png',
                  fit: BoxFit.cover,
                )),
            Text(
              weatherData['description'],
              style: kStyle,
            ),
            Text(
              '${weatherData['temp']}°',
              style: kStyle,
            ),
            Text('Humidity : ' + '${weatherData['humidity']}',
                style: kStyle.copyWith(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
