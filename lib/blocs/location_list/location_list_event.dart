import 'package:equatable/equatable.dart';

abstract class LocationListEvent extends Equatable {
  const LocationListEvent();

  @override
  List<Object> get props => [];
}

class GetLocations extends LocationListEvent {
  @override
  List<Object> get props => null;
}
