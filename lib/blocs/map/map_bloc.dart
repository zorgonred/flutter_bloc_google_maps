import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gtbuddy/models/map_routes.dart';
import 'package:gtbuddy/services/map.dart';
import 'bloc.dart';

class MapBloc extends Bloc<MapEvent, MapLocState> {
  @override
  MapLocState get initialState => MapLoading();

  @override
  Stream<MapLocState> mapEventToState(
    MapEvent event,
  ) async* {
    if (event is GetMapLocations) {
      var loadRoutesBySelectedStation =
          await MapLocations().loadRoutesBySelectedStation(event.selectStation);
      var loadBusStopsBySelectedStation = await MapLocations()
          .loadBusStopsBySelectedStation(event.selectStation);


      double initialLat = event.initialLat;
      double initialLong = event.initialLong;

      var liveBusStatisonFromAPI = await MapLocations().liveBusStatisonFromAPI(event.selectStation);
      yield MapLoaded(
          loadRoutesBySelectedStation: loadRoutesBySelectedStation,
          loadBusBySelectedStation: loadBusStopsBySelectedStation,
          initialLat: initialLat,
          initialLong: initialLong,
        liveBusStatisonFromAPI: liveBusStatisonFromAPI,
          );
    }
  }
}
