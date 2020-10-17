import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Models/Temperature.dart';
import 'package:weather_app/Screens/DetailsWeather.dart';

class City extends StatefulWidget {
  @override
  _CityState createState() => _CityState();
}

class _CityState extends State<City> {
  final _form = GlobalKey<FormState>();
  final _controller = TextEditingController();
  bool _isLoaded = false;
  void save() {
    if (_form.currentState.validate()) return;
    _form.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Temperature>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('Weather'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontSize: 22.5,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      decoration: InputDecoration(
                          prefix: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(Icons.gps_fixed),
                          ),
                          labelText: 'City',
                          hintText: 'Enter City Here',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 22.5)),
                      validator: (cityName) {
                        if (cityName.isEmpty) return 'Please Enter City Name';
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      save();
                      setState(() {
                        _isLoaded = true;
                      });
                      try {
                        await data.fetchAndSet(_controller.text);
                      } catch (error) {
                        return showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: Text('Some Errors!!'),
                                content: Text(
                                  'Please Enter City Name Correctly',
                                ),
                                actions: [
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                        setState(() {
                                          _isLoaded = false;
                                        });
                                      },
                                      child: Text('Okey')),
                                ],
                              );
                            });
                      }
                      setState(() {
                        _isLoaded = false;
                      });
                      _controller.clear();
                      Navigator.of(context).pushNamed(
                        DetailsWeather.routeName,
                      );
                    },
                    child: _isLoaded
                        ? Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.red,
                            ),
                          )
                        : Text(
                            'Get Weather',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                          ),
                    color: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
