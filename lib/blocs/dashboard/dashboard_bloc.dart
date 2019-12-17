import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gtbuddy/services/dashboard_closest_station.dart';
import 'package:gtbuddy/services/dashboard_saved_stations.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardSavedBloc
    extends Bloc<DashboardSavedEvent, DashboardSavedState> {
  @override
  DashboardSavedState get initialState => SavedLoading();

  @override
  Stream<DashboardSavedState> mapEventToState(
    DashboardSavedEvent event,
  ) async* {
    final currentState = state;

    if (event is LoadSaved) {
      print('Event came');

      var mySavedStations = await SavedService().selectSavedStation();
      var closest = await ClosestStation().closestLocation();

      yield SavedLoaded(savedStationss: mySavedStations, closest: closest);
    } else if (event is AddSaved) {
      print('Event saved');

      var selected = await SavedService().addtoList(event.selected);
      yield Add(select: selected);
    }
  }
}
