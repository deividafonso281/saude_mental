import 'dart:convert';
import 'package:http/http.dart' as http;

class CoordinatesService {
  static Future<Map<String, double>?> _getCoordinates(String address) async {
    final encodedAddress = Uri.encodeComponent(address);
    final apiUrl =
        'https://nominatim.openstreetmap.org/search?q=$encodedAddress&format=json&limit=1';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List<dynamic>;
      if (body.isNotEmpty) {
        final firstResult = body.first;
        final lat = double.parse(firstResult['lat']);
        final lng = double.parse(firstResult['lon']);
        return {'latitude': lat, 'longitude': lng};
      }
    }
    return null; // Failed to retrieve coordinates
  }

  static Future<Map<String, double>?> fetchCoordinatesByAddrees(
      String street, String city, String state, String postalCode) {
    final address = '$street, $city, $state $postalCode, Brasil';
    return _getCoordinates(address);
  }
}
