import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherFactory weatherFactory = WeatherFactory(apiKey);

  Weather? weather;
  String selectedCity = "Surat";
  List<String> cities = [
    "Surat",
    "Mumbai",
    "Ahmedabad",
    "Pune",
    "Delhi",
    "London",
    "Melbourne"
  ];

  @override
  void initState() {
    super.initState();
    fetchWeather(selectedCity);
  }

  void fetchWeather(String city) {
    weatherFactory.currentWeatherByCityName(city).then((onValue) {
      setState(() {
        weather = onValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButton<String>(
                hint: const Text(
                  "Select City",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                borderRadius: BorderRadius.circular(10),
                padding: const EdgeInsets.all(10),
                iconEnabledColor: Colors.black,
                isExpanded: true,
                items: cities.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCity = newValue!;
                    fetchWeather(selectedCity);
                  });
                },
              ),
              weather == null
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          locationHeader(),
                          dateTimeInfo(),
                          weatherDetails()
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget locationHeader() {
    return Text(
      weather?.areaName ?? "",
      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
    );
  }

  Widget dateTimeInfo() {
    DateTime now = weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(fontSize: 35),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(width: 20),
            Text(
              DateFormat("d.m.y").format(now),
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  Widget weatherDetails() {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.cloudSun,
                      size: 40.0,
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "${weather!.sunrise!.hour.toString()}:",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          weather!.sunrise!.minute.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const Text("Sunrise")
                  ],
                ),
                Image.network(
                    "http://openweathermap.org/img/wn/${weather?.weatherIcon}@4x.png"),
                Column(
                  children: [
                    const Icon(
                      Icons.wb_twighlight,
                      size: 40,
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "${weather!.sunset!.hour.toString()}:",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          weather!.sunset!.minute.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Text("Sunset")
                  ],
                ),
              ],
            ),
            // Text(
            //   weather?.weatherDescription ?? "",
            //   style: const TextStyle(fontSize: 15),
            // )
            Text(
              (weather?.weatherDescription != null &&
                      weather!.weatherDescription!.isNotEmpty)
                  ? weather!.weatherDescription![0].toUpperCase() +
                      weather!.weatherDescription!.substring(1)
                  : "",
              style: const TextStyle(fontSize: 15),
            )
          ],
        ),
        Text(
          "${weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
          style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w700),
        ),
        Text(
          "Feels like ~ ${weather?.tempFeelsLike?.celsius?.toStringAsFixed(0)}° C",
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width * 0.80,
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Max : ${weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Min : ${weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Wind : ${weather?.windSpeed?.toStringAsFixed(0)} m/s",
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Humidity : ${weather?.humidity?.toStringAsFixed(0)} %",
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
