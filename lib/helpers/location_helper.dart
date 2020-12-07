import 'dart:convert';

import 'package:http/http.dart' as http;

class LocationHelper {
  static String generateLocationPreviewImageUrl(
      double latitude, double longitude) {
    return 'https://static-maps.yandex.ru/1.x/?l=map&ll=$longitude,$latitude&pt=$longitude,$latitude,pm2dbl&z=11';
  }

  static Future<String> getLocationAddress(
      double latitude, double longitude) async {
    final response = await http.get(
        'http://api.geonames.org/findNearestAddressJSON?lat=$latitude&lng=$longitude&username=demo');

    final jsonResponse = json.decode(response.body);

    if (jsonResponse['address'] != null) {
      final jsonAddress = jsonResponse['address'];
      return '${jsonAddress['placename']}, ${jsonAddress['street']} Street No. ${jsonAddress['streetNumber']}, ${jsonAddress['adminName2']}, ${jsonAddress['adminName1']}, ${jsonAddress['postalcode']}';
    } else {
      return null;
    }
  }
}
