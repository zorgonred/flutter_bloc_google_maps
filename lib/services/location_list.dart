import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:gtbuddy/models/locations.dart';

class LocationList {
  Future<List<Locations>> fetchLocations() async {
    String fetchLocations = await rootBundle.loadString('assets/locations/BusStations.json');

    List<dynamic> parsedJson = jsonDecode(fetchLocations);

    return parsedJson.map((jsonObject) {
      return Locations.fromJson(jsonObject);
    }).toList();
  }
}
