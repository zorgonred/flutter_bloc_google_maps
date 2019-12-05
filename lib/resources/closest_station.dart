import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class ClosestStation {


  Future<Map<String, dynamic>> closestLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    String busStationsJson =
    await rootBundle.loadString('assets/locations/BusStations.json');

    final busStations =
    json.decode(busStationsJson).cast<Map<String, dynamic>>();

    var nearest;

    Map<String, dynamic> _nearestLocation;

    while (busStations.length > 0) {
      if (nearest == null) {
        nearest = await Geolocator().distanceBetween(
          position.latitude,
          position.longitude,
          busStations[busStations.length - 1]['latitude'],
          busStations[busStations.length - 1]['longitude'],
        );
        _nearestLocation = busStations[busStations.length - 1];
        busStations.removeLast();
      } else {
        var checkClosest = await Geolocator().distanceBetween(
          position.latitude,
          position.longitude,
          busStations[busStations.length - 1]['latitude'],
          busStations[busStations.length - 1]['longitude'],
        );

        if (checkClosest < nearest) {
          nearest = checkClosest;
          _nearestLocation = busStations[busStations.length - 1];
        }

        busStations.removeLast();
      }
    }

    return _nearestLocation;
  }
}