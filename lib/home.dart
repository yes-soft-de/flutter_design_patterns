import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patterns_app/coord_bloc.dart';
import 'package:patterns_app/coord_event.dart';
import 'package:patterns_app/coord_state.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoordBloc, CoordState>(
      builder: (BuildContext context, state) {
        print(state.toString());
        if (state is CoordInitState) {
          BlocProvider.of<CoordBloc>(context).add(CoordEvent.EVENT_REFRESH);
          return drawLoadingScreen();
        } else if (state is CoordLoadingState) {
          return drawLoadingScreen();
        } else if (state is CoordLoadErrorState) {
          return drawErrorScreen();
        } else if (state is CoordLoadSuccessState) {
          print('Got Success Event');
          CoordLoadSuccessState successState = state;
          return drawSuccessScreen(successState.coordModel.lon.toString(),
              successState.coordModel.lat.toString());
        } else {
          return drawErrorScreen();
        }
      },
    );
  }

  drawSuccessScreen(String lat, String lan) {
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
                children: <Widget>[Text('lon: '), Text(lan)],
              ),
              Flex(
                direction: Axis.horizontal,
                children: <Widget>[Text('lat: '), Text(lat)],
              )
            ],
          ),
          _reloadButton()
        ],
      )),
    );
  }

  drawErrorScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[Text('Load Error'), _reloadButton()],
        ),
      ),
    );
  }

  drawLoadingScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[Text('Loading'), _reloadButton()],
        ),
      ),
    );
  }

  RaisedButton _reloadButton() {
    return RaisedButton(
      onPressed: () {
        BlocProvider.of<CoordBloc>(context).add(CoordEvent.EVENT_REFRESH);
      },
      child: Text('Reload'),
    );
  }
}
