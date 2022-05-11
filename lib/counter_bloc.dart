import 'dart:async';

enum CounterAction { Increment, Decrement, Reset }

class CounterBloc {
  late int counter;

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
    counter = 0;
    eventStream.listen((event) {
      if (event == CounterAction.Increment) {
        counter++;
      } else if (event == CounterAction.Decrement) {
        counter--;
      } else if (event == CounterAction.Reset) {
        counter = 0;

        //
        counterSink.add(counter);
      }
    });
  }
}
