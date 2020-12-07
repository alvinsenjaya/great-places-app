import 'package:flutter/material.dart';
import 'package:great_places_app/helpers/location_helper.dart';
import 'package:great_places_app/models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  @override
  Widget build(BuildContext context) {
    final Place _place = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text(_place.title)),
      body: ListView(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.file(
              _place.image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Location',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          if (_place.location.address != null)
            Text(
              _place.location.address,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
              ),
            ),
          Container(
            height: 200,
            decoration: BoxDecoration(
                border: Border.all(
              width: 1,
              color: Colors.grey,
            )),
            alignment: Alignment.center,
            width: double.infinity,
            child: Image.network(
              LocationHelper.generateLocationPreviewImageUrl(
                _place.location.latitude,
                _place.location.longitude,
              ),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
