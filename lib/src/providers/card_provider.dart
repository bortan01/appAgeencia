import 'dart:async';

class CardProvider {
  static final CardProvider _singleton = new CardProvider._internal();
  factory CardProvider() {
    return _singleton;
  }
  CardProvider._internal();

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
