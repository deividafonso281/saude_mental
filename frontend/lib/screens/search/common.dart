import 'dart:math';

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371; // Earth's radius in kilometers

  double toRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  double deltaLat = toRadians(lat2 - lat1);
  double deltaLon = toRadians(lon2 - lon1);

  double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
      cos(toRadians(lat1)) *
          cos(toRadians(lat2)) *
          sin(deltaLon / 2) *
          sin(deltaLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  double distance = earthRadius * c;
  return distance;
}
