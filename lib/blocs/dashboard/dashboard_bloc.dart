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

  List<String> mysavedstations;
  String selectedd;
  Map<String, dynamic> closest;

  @override
  Stream<DashboardSavedState> mapEventToState(
    DashboardSavedEvent event,
  ) async* {
    final currentState = state;
    // TODO: Add Logic
    if (event is LoadSaved) {
      print('Event came');

      mysavedstations = await SavedService().selectSavedStation();
      closest = await ClosestStation().closestLocation();
      yield SavedLoaded(savedstationss: mysavedstations, closest: closest);
    } else if (event is AddSaved) {
      print('Event saved');

      selectedd = await SavedService().addtoList(event.selected);
      yield Add(select: selectedd);
    }
  }
}
