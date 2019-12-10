import 'dart:convert';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:gtbuddy/models/saved_stations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';

class LocationBloc extends BlocBase {
  final _locationsFetcher = PublishSubject<List<SavedStations>>();

  Observable<List<SavedStations>> get allLocations => _locationsFetcher.stream;

  fetchAllLocations(BuildContext context) async {
    List<SavedStations> savedStations = await getLocalBusLocations(context);
    _locationsFetcher.sink.add(savedStations);
  }

  Future<Map<String, dynamic>> savedLocation(String shortName) async {
    String busStationsJson = await rootBundle.loadString('assets/locations/BusStations.json');

    List<dynamic> busStations = json.decode(busStationsJson);

    return busStations.singleWhere((element) {
      return element["short_name"] == shortName;
    });
  }

  Future<Map<String, dynamic>> closestLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    String busStationsJson = await rootBundle.loadString('assets/locations/BusStations.json');

    final busStations = json.decode(busStationsJson).cast<Map<String, dynamic>>();

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

  Future<List<SavedStations>> getLocalBusLocations(BuildContext context) async {
    final busLocations = await DefaultAssetBundle.of(context).loadString('assets/locations/BusStations.json');

    List<dynamic> busLocationsDecoded = jsonDecode(busLocations);

    List<SavedStations> busLocationCustomized = List<SavedStations>();

    busLocationsDecoded.forEach((data) {
      busLocationCustomized.add(SavedStations.fromJson(data));
    });

    return busLocationCustomized;
  }

  @override
  void dispose() {
    _locationsFetcher.close();
  }
}
