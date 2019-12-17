import 'package:equatable/equatable.dart';



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
  final List<String> savedstationss;
  final Map<String, dynamic> closest;
  SavedLoaded({this.savedstationss, this.closest});

  @override
  // TODO: implement props
  List<Object> get props => [savedstationss];
}

class SavedNotLoaded extends DashboardSavedState {}
