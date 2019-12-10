// To parse this JSON data, do
//
//     final savedStations = savedStationsFromJson(jsonString);

import 'dart:convert';

List<SavedStations> savedStationsFromJson(String str) => List<SavedStations>.from(json.decode(str).map((x) => SavedStations.fromJson(x)));

String savedStationsToJson(List<SavedStations> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SavedStations {
    double longitude;
    double latitude;
    String shortName;
    String code;
    int sort;

    SavedStations({
        this.longitude,
        this.latitude,
        this.shortName,
        this.code,
        this.sort,
    });

    factory SavedStations.fromJson(Map<String, dynamic> json) => SavedStations(
        longitude: json["longitude"].toDouble(),
        latitude: json["latitude"].toDouble(),
        shortName: json["short_name"],
        code: json["code"],
        sort: json["sort"],
    );

    Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
        "short_name": shortName,
        "code": code,
        "sort": sort,
    };
}
