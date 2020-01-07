import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gtbuddy/services/dashboard_closest_station.dart';
import 'package:gtbuddy/services/dashboard_saved_stations.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardSavedBloc extends Bloc<DashboardSavedEvent, DashboardSavedState> {
  @override
  DashboardSavedState get initialState => SavedLoading();

  @override
  Stream<DashboardSavedState> mapEventToState(
    DashboardSavedEvent event,
  ) async* {
    if (event is LoadSaved) {
      var mySavedStations = await SavedService().selectSavedStation();
      var closest = await ClosestStation().closestLocation();
      yield SavedLoaded(savedStations: mySavedStations, closest: closest);
    } else if (event is AddSaved) {
      var selected = await SavedService().addToList(event.selected);
      yield Add(select: selected);
    }
  }
}
