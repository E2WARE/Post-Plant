import '../models/maps_model.dart';

class MapCardViewModel {
  final MapModel map;
  final Function(String) onMapSelected;

  MapCardViewModel({required this.map, required this.onMapSelected});

  void selectMap() {
    onMapSelected(map.mapName);
  }

  String get mapName => map.mapName;
}