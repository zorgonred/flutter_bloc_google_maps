import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:gtbuddy/models/locations.dart';
import 'package:gtbuddy/services/location_list.dart';
import 'bloc.dart';

class LocationlistBloc extends Bloc<LocationlistEvent, LocationlistState> {
  @override
  LocationlistState get initialState => InitialLocationlistState();

  List<Locations> mystations;
  String station;
  String myadd;
  @override
  Stream<LocationlistState> mapEventToState(
    LocationlistEvent event,
  ) async* {
    final currentState = state;
    // TODO: Add Logic
    if (event is GetLocations) {
      print('Event came');
      yield LocationListLoading();

      mystations = await LocationList().fetchLocations();
      yield LocationListLoaded(stations: mystations);
    }
  }

}
