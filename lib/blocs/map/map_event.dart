import 'package:equatable/equatable.dart';
import 'package:gtbuddy/models/map_bus_live.dart';
import 'package:gtbuddy/models/map_routes.dart';
import 'package:meta/meta.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class GetMapLocations extends MapEvent {
  final String selectStation;
  final String selectCoords;
  final double initialLat;
  final double initialLong;
  final LiveBus liveBusStatisonFromAPI;


  const GetMapLocations({@required this.selectStation, @required this.selectCoords,
    @required this.initialLat, @required this.initialLong, @required this.liveBusStatisonFromAPI });

  @override
  List<Object> get props => [selectStation, selectCoords, initialLat,initialLong, this.liveBusStatisonFromAPI ];
}
