import 'package:equatable/equatable.dart';


abstract class MapEvent extends Equatable {
  const MapEvent();
  @override
  List<Object> get props => [];
}

class GetMapLocations extends MapEvent {

  final String selectStation;
  final String selectCoords;
  final String appBar;
  final double initialLat;
  final double initialLong;


  const GetMapLocations({this.selectStation, this.selectCoords, this.appBar,this.initialLat, this.initialLong});

  @override
  List<Object> get props => [selectStation,selectCoords,appBar,initialLat,initialLong];
}