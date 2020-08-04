import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patterns_app/coord_model.dart';
import 'package:patterns_app/main_bloc.dart';
import 'package:patterns_app/main_bloc_event.dart';
import 'package:patterns_app/main_bloc_state.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherBlocState currentState = WeatherStateInit();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainBloc, WeatherBlocState>(
      listener: (context, state) {
        currentState = state;
        setState(() {});
      },
      child: getStateScreen(),
    );
  }

  Scaffold getStateScreen() {
    if (currentState is WeatherStateInit) {
      BlocProvider.of<MainBloc>(context)
          .add(MainBlocEvent.EVENT_REFRESH);
    }
    if (currentState is WeatherStateLoadSuccess) {
      WeatherStateLoadSuccess successState = currentState;
      return drawSuccessScreen(
          successState.model.lon.toString(), successState.model.lat.toString());
    } else if (currentState is WeatherStateRefreshing) {
      return drawProgressScreen();
    } else {
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
          drawDataLine(lon, lat),
          _reloadButton()
        ],
      )),
    );
  }

  Scaffold drawErrorScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Error Loading Data'),
            _reloadButton()
          ],
        ),
      ),
    );
  }

  Scaffold drawProgressScreen() {
    return Scaffold(
      body: Center(child: Text('Loading')),
    );
  }

  Row drawDataLine(String lon, String lat) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Flex(
          direction: Axis.horizontal,
          children: <Widget>[Text('lon: '), Text(lon)],
        ),
        Flex(
          direction: Axis.horizontal,
          children: <Widget>[Text('lat: '), Text(lat)],
        ),
      ],
    );
  }

  RaisedButton _reloadButton() {
    return RaisedButton(
      onPressed: () {
        BlocProvider.of<MainBloc>(context)
            .add(MainBlocEvent.EVENT_REFRESH);
      },
      child: Text('Refresh'),
    );
  }
}
