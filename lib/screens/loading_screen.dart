import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/services/location.dart';

const apiKey = 'ca0491db415b1bcb2c7e30233445aae6';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude;
  late double longitude;

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;

    print('lat: $latitude');
    print('lon: $longitude');

    getData();
  }

  void getData() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey'));
    if (response.statusCode == 200) {
      String data = response.body;

      var decodeData = jsonDecode(data);

      var city = decodeData['name'];
      var condition = decodeData['weather'][0]['main'];

      print(city);
      print(condition);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
