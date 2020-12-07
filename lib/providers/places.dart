import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places_app/helpers/db_helper.dart';
import 'package:great_places_app/models/place.dart';
import 'package:uuid/uuid.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image, PlaceLocation location) {
    Place _place = Place(
      id: Uuid().v4(),
      image: image,
      location: location,
      title: title,
    );

    _items.add(_place);

    notifyListeners();

    DbHelper.insert('user_places', {
      'id': _place.id,
      'title': _place.title,
      'image': _place.image.path,
      'loc_latitude': _place.location.latitude,
      'loc_longitude': _place.location.longitude,
      'loc_address': _place.location.address,
    });
  }

  void deletePlaceById(String id) {
    _items.removeWhere((element) => element.id == id);

    notifyListeners();

    DbHelper.deleteById('user_places', id);
  }

  Future<void> fetchAndSetPlaces() async {
    final queryResult = await DbHelper.getData('user_places');

    _items = queryResult
        .map(
          (e) => Place(
            id: e['id'],
            image: File(e['image']),
            title: e['title'],
            location: PlaceLocation(
              latitude: e['loc_latitude'],
              longitude: e['loc_longitude'],
              address: e['loc_address'],
            ),
          ),
        )
        .toList();

    notifyListeners();
  }
}
