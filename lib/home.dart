import 'package:flutter/material.dart';
import 'package:patterns_app/coord_model.dart';
import 'package:patterns_app/fake_server.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FakeServer _server = FakeServer();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _server.getWeather(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(child: Text('Error Loading Data')),
          );
        }

        CoordModel response = CoordModel.fromJson(snapshot.data);

        return Scaffold(
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Weather Application',
                style: TextStyle(color: Colors.blue, fontSize: 24),
              ),
              Row(
                children: <Widget>[
                  Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[Text('lon: '), Text(response.lon.toString())],
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[Text('lat: '), Text(response.lat.toString())],
                  )
                ],
              )
            ],
          )),
        );
      },
    );
  }
}
