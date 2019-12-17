import 'package:equatable/equatable.dart';
import 'package:gtbuddy/models/locations.dart';


abstract class LocationlistState extends Equatable {
  const LocationlistState();
  @override
  List<Object> get props => [];
}

class InitialLocationlistState extends LocationlistState {}

class LocationListLoading extends LocationlistState {}

class LocationListLoaded extends LocationlistState {
  final List<Locations> stations;

  LocationListLoaded({this.stations});

  @override
  // TODO: implement props
  List<Object> get props => [stations];
}

