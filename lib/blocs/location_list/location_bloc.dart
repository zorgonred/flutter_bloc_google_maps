import 'package:flutter/cupertino.dart';
import 'package:gtbuddy/resources/repository.dart';
import 'package:gtbuddy/models/savedStations.dart';
import 'package:rxdart/rxdart.dart';


class LocationBloc {
  final _repository = Repository();
  final _locationsFetcher = PublishSubject<List<SavedStations>>();

  Observable<List<SavedStations>> get allLocations => _locationsFetcher.stream;

  fetchAllLocations(BuildContext context) async {
    List<SavedStations> savedStations = await _repository.fetchAllLocations(context);
    _locationsFetcher.sink.add(savedStations);
  }

  bool _isDisposed = false;
  dispose() {
    _isDisposed = true;
    _locationsFetcher.close();
  }
}

final bloc = LocationBloc();
