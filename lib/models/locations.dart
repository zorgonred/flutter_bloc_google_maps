// To parse this JSON data, do
//
//     final locations = locationsFromJson(jsonString);

import 'dart:convert';

List<Locations> locationsFromJson(String str) => List<Locations>.from(json.decode(str).map((x) => Locations.fromJson(x)));

String locationsToJson(List<Locations> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Locations {
    double longitude;
    double latitude;
    String shortName;
    String code;
    int sort;

    Locations({
        this.longitude,
        this.latitude,
        this.shortName,
        this.code,
        this.sort,
    });

    factory Locations.fromJson(Map<String, dynamic> json) => Locations(
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
