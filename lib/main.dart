import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart';

void main() => runApp(MaterialApp(
      title: "Clima App",
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var name;
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  var response;

  //var forecastUrl = 'https://api.openweathermap.org/data/2.5/forecast?q=Cabimas&units=metric&appid=c86795d90f73b3f3564339865ce6d26b&lang=es';

  Future getWeather() async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get(
        "https://api.openweathermap.org/data/2.5/weather?q=Maracaibo&units=metric&appid=c86795d90f73b3f3564339865ce6d26b&lang=es");

    var results = response.data;

    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
      this.name = results['name'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 2.7,
          width: MediaQuery.of(context).size.width,
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Text(
                  name != null
                      ? "Currently en " + name.toString() + " por degracia"
                      : 'what',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                temp != null ? temp.toString() + "\u00B0" : "marditos todos",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  description != null ? description.toString() : "loading",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                title: Text("Temperature"),
                trailing: Text(
                  temp != null ? temp.toString() + "\u00B0" : "Me",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.cloud),
                title: Text("Weather"),
                trailing: Text(
                  description != null ? description.toString() : "Cago",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.sun),
                title: Text("Humidity"),
                trailing: Text(
                  humidity != null ? humidity.toString() + " %" : "en",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.wind),
                title: Text("WindSpeed"),
                trailing: Text(
                  windSpeed != null ? windSpeed.toString() + " Km/H" : "todo",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    ));
  }
}
