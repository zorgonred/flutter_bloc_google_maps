import 'package:json_annotation/json_annotation.dart';

part 'busStations.g.dart';

@JsonSerializable()
class BusStations {
    BusStations();

    num longitude;
    num latitude;
    String short_name;
    String code;
    num sort;
    
    factory BusStations.fromJson(Map<String,dynamic> json) => _$BusStationsFromJson(json);
    Map<String, dynamic> toJson() => _$BusStationsToJson(this);
}
