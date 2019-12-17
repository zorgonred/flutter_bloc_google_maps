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
  var initialLat;
  var initialLong;

  GetMapLocations(this.selectStation, this.selectCoords, this.appBar,this.initialLat, this.initialLong);

  @override
  // TODO: implement props
  List<Object> get props => null;
}