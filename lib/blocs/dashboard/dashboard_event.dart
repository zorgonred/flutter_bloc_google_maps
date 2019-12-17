import 'package:equatable/equatable.dart';
import 'package:gtbuddy/models/locations.dart';
import 'package:meta/meta.dart';

abstract class DashboardSavedEvent extends Equatable {
  const DashboardSavedEvent();

  @override
  List<Object> get props => [];
}

class LoadSaved extends DashboardSavedEvent {}

class AddSaved extends DashboardSavedEvent {
  final String selected;

  const AddSaved({@required this.selected});

  @override
  List<Object> get props => [selected];
}

class DeleteSaved extends DashboardSavedEvent {
  final Locations saved;

  const DeleteSaved(this.saved);

  @override
  List<Object> get props => [saved];

  @override
  String toString() => 'DeleteSaved { saved: $saved }';
}
