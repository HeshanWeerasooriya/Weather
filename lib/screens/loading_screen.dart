import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/services/location.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    getLocation();
    getData();
    super.initState();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
  }

  void getData() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=ca0491db415b1bcb2c7e30233445aae6'));
    if (response.statusCode == 200) {
      String data = response.body;

      var city = jsonDecode(data)['name'];
      var conddition = jsonDecode(data)['weather'][0]['main'];

      print(city);
      print(conddition);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
