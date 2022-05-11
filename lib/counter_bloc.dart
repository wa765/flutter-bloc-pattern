import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum CounterAction { Increment, Decrement, Reset }

class CounterBloc {
  int counter = 0;
  final _stateStreamController = StreamController<int>();
  // sink for input
  StreamSink<int> get counterSink {
    return _stateStreamController.sink;
  }

  // stream for output
  Stream<int> get counterStream {
    return _stateStreamController.stream;
  }

  //
  final _eventStreamController = StreamController<CounterAction>();
  // sink for input
  StreamSink<CounterAction> get eventSink {
    return _eventStreamController.sink;
  }

  // stream for output
  Stream<CounterAction> get eventStream {
    return _eventStreamController.stream;
  }

  // Logic Event
  CounterBloc() {
    eventStream.listen((event) {
      if (event == CounterAction.Increment) {
        counter++;
      } else if (event == CounterAction.Decrement) {
        counter--;
        // jika angka sudah 0 tidak akan bisa di decrement lagi
        if (counter < 0) {
          counter = 0;
        }
      } else if (event == CounterAction.Reset) {
        counter = 0;
      }
      counterSink.add(counter);
    });
  }
}
