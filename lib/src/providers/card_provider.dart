import 'dart:async';

class CardProvider {
  final _cardStream = StreamController<int>.broadcast();

  void disposeStreams() {
    _cardStream?.close();
  }

  Function(int) get cardSink => _cardStream.sink.add;
  Stream<int> get cardStreamX => _cardStream.stream;

  void cambiarCard(int card) {
    cardSink(card);
  }
}
