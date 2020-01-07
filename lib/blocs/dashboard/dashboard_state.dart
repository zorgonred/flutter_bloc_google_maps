import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class DashboardSavedState extends Equatable {
  const DashboardSavedState();

  @override
  List<Object> get props => [];
}

class Initial extends DashboardSavedState {}

class SavedLoading extends DashboardSavedState {}

class Add extends DashboardSavedState {
  final String select;

  Add({this.select});
}

class SavedLoaded extends DashboardSavedState {
  final List<String> savedStations;
  final Map<String, dynamic> closest;

  SavedLoaded({@required this.savedStations, @required this.closest});

  @override
  List<Object> get props => [savedStations, closest];
}

class SavedNotLoaded extends DashboardSavedState {}
