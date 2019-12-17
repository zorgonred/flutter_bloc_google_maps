import 'package:equatable/equatable.dart';
import 'package:gtbuddy/models/locations.dart';

abstract class LocationListState extends Equatable {
  const LocationListState();

  @override
  List<Object> get props => [];
}

class InitialLocationListState extends LocationListState {}

class LocationListLoading extends LocationListState {}

class LocationListLoaded extends LocationListState {
  final List<Locations> stations;

  LocationListLoaded({this.stations});

  @override
  List<Object> get props => [stations];
}
