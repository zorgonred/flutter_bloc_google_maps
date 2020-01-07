import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gtbuddy/services/location_list.dart';
import 'bloc.dart';

class LocationListBloc extends Bloc<LocationListEvent, LocationListState> {
  @override
  LocationListState get initialState => InitialLocationListState();

  @override
  Stream<LocationListState> mapEventToState(
    LocationListEvent event,
  ) async* {
    if (event is GetLocations) {
      yield LocationListLoading();
      var myStations = await LocationList().fetchLocations();
      yield LocationListLoaded(stations: myStations);
    }
  }
}
