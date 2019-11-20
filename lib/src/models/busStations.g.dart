// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'busStations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusStations _$BusStationsFromJson(Map<String, dynamic> json) {
  return BusStations()
    ..longitude = json['longitude'] as num
    ..latitude = json['latitude'] as num
    ..short_name = json['short_name'] as String
    ..code = json['code'] as String
    ..sort = json['sort'] as num;
}

Map<String, dynamic> _$BusStationsToJson(BusStations instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'short_name': instance.short_name,
      'code': instance.code,
      'sort': instance.sort
    };
