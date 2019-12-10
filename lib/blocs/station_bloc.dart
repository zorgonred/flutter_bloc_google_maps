import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StationBloc extends BlocBase {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future saveStationOnMySavedStation(String station) async {
    final SharedPreferences prefs = await _prefs;
    var currentSavedStations = await selectSavedStation();

    if (currentSavedStations.isNotEmpty) {
      var existsStation = currentSavedStations.any((x) => x == station.trim());

      if (!existsStation) {
        currentSavedStations.add(station);
        await _saveStationOnPreferences(prefs, currentSavedStations);
      }
    } else {
      var savedStations = List<String>();
      savedStations.add(station);
      await _saveStationOnPreferences(prefs, savedStations);
    }
  }

  Future _saveStationOnPreferences(
      SharedPreferences prefs, List<String> list) async {
    await prefs.setStringList('savedStations', list);
  }

  Future<List<String>> selectSavedStation() async {
    final SharedPreferences prefs = await _prefs;
    var currentSavedStations = prefs.getStringList('savedStations');
    return currentSavedStations ?? List<String>();
  }

  Future deleteSavedStationByIndex(int index) async {
    final SharedPreferences prefs = await _prefs;
    var list = await selectSavedStation();
    list.removeAt(index);
    await _saveStationOnPreferences(prefs, list);
  }
}
