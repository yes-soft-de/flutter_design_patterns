import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:patterns_app/coord_model.dart';

import 'home_bloc.dart';

class HomeScreen extends StatefulWidget {
  final HomeBloc bloc = new HomeBloc();

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

// Home Page State:
class _HomeScreenState extends State<HomeScreen> {
  int currentState = HomeBloc.STATUS_CODE_INIT;
  CoordModel payload;

  @override
  Widget build(BuildContext context) {
    widget.bloc.stateStream.listen((event) {
      currentState = event[HomeBloc.KEY_STATUS];

      if (currentState == HomeBloc.STATUS_CODE_SUCCESS) {
        payload = event[HomeBloc.KEY_PAYLOAD];
      }

      setState(() {});
    });

    switch (currentState) {
      case HomeBloc.STATUS_CODE_INIT:
        widget.bloc.getWeather();
        return drawLoadingScreen();
      case HomeBloc.STATUS_CODE_LOADING:
        return drawLoadingScreen();
      case HomeBloc.STATUS_CODE_SUCCESS:
        return drawSuccessScreen(
            payload.lat.toString(), payload.lon.toString());
      default:
        return drawErrorScreen();
    }
  }

  Scaffold drawSuccessScreen(String lat, String lon) {
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
                children: <Widget>[Text('lon: '), Text(lon)],
              ),
              Flex(
                direction: Axis.horizontal,
                children: <Widget>[Text('lat: '), Text(lat)],
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
  }

  Scaffold drawErrorScreen() {
    return Scaffold(
      body: Center(
        child: Text('Error Loading Data'),
      ),
    );
  }

  Scaffold drawLoadingScreen() {
    return Scaffold(
      body: Center(
        child: Text('Loading'),
      ),
    );
  }
}
