import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:patterns_app/coord_model.dart';
import 'package:patterns_app/fake_server.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}
// Home Page State:
/*
      1. Displays UI
      2. Request from Backend
      3. Decode the response
      4. Error Handling
      5. State Management
 */
class _HomeScreenState extends State<HomeScreen> {
  FakeServer _server = FakeServer();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _server.getWeather(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(child: Text('Error Loading Data')),
          );
        }

        CoordModel response = CoordModel.fromJson(jsonDecode(snapshot.data));

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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Text('lon: '),
                      Text(response.lon.toString())
                    ],
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Text('lat: '),
                      Text(response.lat.toString())
                    ],
                  )
                ],
              ),
              RaisedButton(
                onPressed: () {
                  _server.getWeather();
                },
                child: Text('Refresh'),
              )
            ],
          )),
        );
      },
    );
  }
}
