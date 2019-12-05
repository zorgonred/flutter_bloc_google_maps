import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gtbuddy/models/savedStations.dart';
import 'package:gtbuddy/models/busLive.dart';
import 'package:gtbuddy/resources/saved_stations.dart';
import 'package:http/http.dart';

class LocationApiProvider {


  Future<List<SavedStations>> fetchLocationList(BuildContext context) async {
    final jsonLocations = await DefaultAssetBundle.of(context)
        .loadString('assets/locations/BusStations.json');
    print(jsonLocations);
    print("hello");
    List<dynamic> mapJsonLocations = jsonDecode(jsonLocations);
    print(mapJsonLocations);

    List<SavedStations> mySavedStations = List<SavedStations>();
    mapJsonLocations.forEach((data) {
      SavedStations stations = SavedStations.fromJson(data);
      mySavedStations.add(stations);
    });

    return mySavedStations;
  }



}
