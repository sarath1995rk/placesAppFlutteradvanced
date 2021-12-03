import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = '';

class LocationHelper {
  static String generateLocationPreviewImage(double? lat, double? lng) {
    return '';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    return '';
  }
}

// String googleStaticApi = 'https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap
// &markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318
//   &markers=color:red%7Clabel:C%7C40.718217,-73.998284
//   &key=YOUR_API_KEY';
