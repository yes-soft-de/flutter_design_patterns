import 'dart:async';

import 'package:rxdart/rxdart.dart';

class FakeServer {
  int requestNumber = 0;

  PublishSubject<String> subject = new PublishSubject();

  Stream<String> getWeather() {
    new Timer(Duration(seconds: 2), () {
      int state = (requestNumber ) % 3;
      print("Sending Response" + state.toString());
      if (state == 0) {
        requestNumber++;
        subject.add('{"lon":-0.13,"lat":51.51}');
      }
      if (state == 1) {
        requestNumber++;
        subject.add('{"msg":"Auth error"}');
      }
      if (state == 2) {
        requestNumber++;
        subject.add('<html> <some>');
      }
    });

    return subject.stream;
  }

  dispose() {
    subject.close();
  }
}
