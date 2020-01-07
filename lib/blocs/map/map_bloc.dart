import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gtbuddy/services/map.dart';
import 'bloc.dart';

class MapBloc extends Bloc<MapEvent, MapLocState> {
  @override
  MapLocState get initialState => InitialMapState();

  @override
  Stream<MapLocState> mapEventToState(
    MapEvent event,
  ) async* {
    if (event is GetMapLocations) {
      yield MapLoading();

      var loadRoutesBySelectedStation = await MapLocations().loadRoutesBySelectedStation(event.selectStation);
      var loadBusStopsBySelectedStation = await MapLocations().loadBusStopsBySelectedStation(event.selectStation);
      var liveBusStatisonFromAPI = await MapLocations().liveBusStatisonFromAPI(event.selectStation);

      yield MapLoaded(
        loadRoutesBySelectedStation: loadRoutesBySelectedStation,
        loadBusStopsBySelectedStation: loadBusStopsBySelectedStation,
        liveBusStatisonFromAPI: liveBusStatisonFromAPI,
      );
    }
  }
}
