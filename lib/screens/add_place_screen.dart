import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places_app/models/place.dart';
import 'package:great_places_app/providers/places.dart';
import 'package:great_places_app/widgets/image_input.dart';
import 'package:great_places_app/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _savedImage;
  String _address;
  double _latitude;
  double _longitude;

  void _selectImage(File pickedImage) {
    _savedImage = pickedImage;
  }

  void _selectLocation(double latitude, double longitude, String address) {
    _latitude = latitude;
    _longitude = longitude;
    _address = address;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _savedImage == null) {
      return;
    }

    Provider.of<Places>(context, listen: false).addPlace(
      _titleController.text,
      _savedImage,
      PlaceLocation(
        latitude: _latitude,
        longitude: _longitude,
        address: _address,
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                    controller: _titleController,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ImageInput(_selectImage),
                  SizedBox(
                    height: 30,
                  ),
                  LocationInput(_selectLocation),
                ],
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            color: Theme.of(context).accentColor,
            onPressed: _savePlace,
          )
        ],
      ),
    );
  }
}
