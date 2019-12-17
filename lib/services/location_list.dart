import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:gtbuddy/models/locations.dart';


class LocationList {
  List<Locations> mystations;

  fetchLocations() async {
    print('Came to fetch locations');
    String jsonString =
    await rootBundle.loadString('assets/locations/BusStations.json');
    print('fetched jsonString');

    List<dynamic> parsedJson = jsonDecode(jsonString);
    print('json Decoded');

    mystations = parsedJson.map((jsonobject) {
      return Locations.fromJson(jsonobject);
    }).toList();

    mystations.forEach((f) {
      print(f.shortName);
    });

    return mystations;
  }
}