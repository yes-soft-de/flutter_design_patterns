import 'dart:async';

import 'package:rxdart/rxdart.dart';

class FakeServer {
  int requestNumber = 0;

  PublishSubject<dynamic> subject = new PublishSubject();

  Stream<dynamic> getWeather() {
    new Timer(Duration(seconds: 5), () {
      if ((requestNumber + 1) % 3 == 0) {
        requestNumber++;
        subject.add('{"lon":-0.13,"lat":51.51}');
      }
      if ((requestNumber + 1) % 3 == 1) {
        requestNumber++;
        subject.add('{"msg":"Auth error"}');
      }
      if ((requestNumber + 1) % 3 == 2) {
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
