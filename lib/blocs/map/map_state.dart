import 'package:equatable/equatable.dart';
import 'package:gtbuddy/models/map_bus_live.dart';

abstract class MapLocState extends Equatable {
  const MapLocState();

  @override
  List<Object> get props => [];
}

class InitialMapState extends MapLocState {}

class MapLoading extends MapLocState {}

class MapLoaded extends MapLocState {
  final String loadRoutesBySelectedStation;
  final String loadBusStopsBySelectedStation;
  final LiveBus liveBusStatisonFromAPI;
  final double initialLat;
  final double initialLong;

  MapLoaded({this.loadRoutesBySelectedStation, this.loadBusStopsBySelectedStation, this.liveBusStatisonFromAPI, this.initialLat, this.initialLong});

  @override
  // TODO: implement props
  List<Object> get props => [loadRoutesBySelectedStation, loadBusStopsBySelectedStation, liveBusStatisonFromAPI, initialLat, initialLong];
}
