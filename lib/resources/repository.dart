import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:gtbuddy/models/busLive.dart';
import 'package:gtbuddy/resources/api_providers.dart';
import 'package:gtbuddy/models/savedStations.dart';

class Repository {
  final locationsApiProvider = LocationApiProvider();

  Future<List<SavedStations>> fetchAllLocations(BuildContext context) => locationsApiProvider.fetchLocationList(context);


  Future<LiveBus> fetchTrailers(int busId) => locationsApiProvider.fetchLive(busId);

}