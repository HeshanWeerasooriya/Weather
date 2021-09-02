import 'package:flutter/material.dart';
import 'package:http/http.dart';
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
    Response response = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=ca0491db415b1bcb2c7e30233445aae6'));
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
