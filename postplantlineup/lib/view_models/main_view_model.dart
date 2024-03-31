import 'dart:async';
import '../data/main_data.dart';
import '../models/main_model.dart';

class GridViewViewModel {
  late List<CardModel> cards;
  late StreamController<List<CardModel>> _cardsController;

  Stream<List<CardModel>> get cardsStream => _cardsController.stream;

  GridViewViewModel() {
    cards = [];
    _cardsController = StreamController<List<CardModel>>.broadcast();
    loadCards();
  }

  Future<void> loadCards() async {
    cards = await CardData.getCards();
    _cardsController.add(cards);
  }

  void dispose() {
    _cardsController.close();
  }
}
