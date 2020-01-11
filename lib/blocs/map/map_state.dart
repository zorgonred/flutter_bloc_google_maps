import 'package:equatable/equatable.dart';
import 'package:gtbuddy/models/map_bus_live.dart';
import 'package:gtbuddy/models/map_routes.dart';
import 'package:gtbuddy/models/map_routes.dart';
import 'package:meta/meta.dart';

abstract class MapLocState extends Equatable {
  const MapLocState();

  @override
  List<Object> get props => [];
}

class InitialMapState extends MapLocState {
}

class MapLoading extends MapLocState {}

class MapLoaded extends MapLocState {
  final String loadRoutesBySelectedStation;
  final String loadBusBySelectedStation;
  final  double initialLat;
  final double initialLong;
  final LiveBus liveBusStatisonFromAPI;



  MapLoaded({@required this.loadRoutesBySelectedStation,@required this.loadBusBySelectedStation,@required this.initialLat, @required this.initialLong , @required this.liveBusStatisonFromAPI });

  @override

  List<Object> get props => [loadRoutesBySelectedStation, loadBusBySelectedStation, initialLat,initialLong, liveBusStatisonFromAPI ];
}
