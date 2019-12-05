import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:gtbuddy/models/busLive.dart';
import 'package:gtbuddy/resources/locations_list.dart';
import 'package:gtbuddy/models/savedStations.dart';

class Repository {

  final locationsApiProvider = LocationApiProvider();

  Future<List<SavedStations>> fetchAllLocations(BuildContext context) => locationsApiProvider.fetchLocationList(context);


}