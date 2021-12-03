import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:places_app/models/place.dart';
import 'package:places_app/helpers/db_helpers.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findPlaceById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  void addPlace(
      String title, File? pickedImage, PlaceLocation? pickedLocation) {
    // final String address = await LocationHelper.getPlaceAddress(
    //     pickedLocation!.latitude, pickedLocation.longitude);
    final updatedLoc =
        PlaceLocation(latitude: 1.666, longitude: .77777, address: '');
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: updatedLoc,
        image: pickedImage!);
    _items.add(newPlace);
    notifyListeners();
    DbHelper.insert('userPlaces', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> deletePlace(String id) async {
    _items.removeWhere((element) => element.id == id);
    DbHelper.deleteItem('userPlaces', id);
    notifyListeners();
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DbHelper.getData('userPlaces');
    _items = dataList.map((data) {
      return Place(
          id: data['id'],
          title: data['title'],
          location: PlaceLocation(longitude: 1.1, latitude: 1.2),
          image: File(data['image']));
    }).toList();

    notifyListeners();
  }
}
