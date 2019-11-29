// To parse this JSON data, do
//
//     final liveBus = liveBusFromJson(jsonString);

import 'dart:convert';

LiveBus liveBusFromJson(String str) => LiveBus.fromJson(json.decode(str));

String liveBusToJson(LiveBus data) => json.encode(data.toJson());

class LiveBus {
  String timestamp;
  Result result;

  LiveBus({
    this.timestamp,
    this.result,
  });

  factory LiveBus.fromJson(Map<String, dynamic> json) => LiveBus(
    timestamp: json["Timestamp"],
    result: Result.fromJson(json["Result"]),
  );

  Map<String, dynamic> toJson() => {
    "Timestamp": timestamp,
    "Result": result.toJson(),
  };
}

class Result {
  List<BusPosition> busPositions;

  Result({
    this.busPositions,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    busPositions: List<BusPosition>.from(json["busPositions"].map((x) => BusPosition.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "busPositions": List<dynamic>.from(busPositions.map((x) => x.toJson())),
  };
}

class BusPosition {
  String busId;
  int currsegment;
  String formattedLastModified;
  String heading;
  int lastModified;
  double latitude;
  double longitude;
  double remainonsegment;
  String routecode;

  BusPosition({
    this.busId,
    this.currsegment,
    this.formattedLastModified,
    this.heading,
    this.lastModified,
    this.latitude,
    this.longitude,
    this.remainonsegment,
    this.routecode,
  });

  factory BusPosition.fromJson(Map<String, dynamic> json) => BusPosition(
    busId: json["busId"],
    currsegment: json["currsegment"],
    formattedLastModified: json["formattedLastModified"],
    heading: json["heading"],
    lastModified: json["lastModified"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    remainonsegment: json["remainonsegment"].toDouble(),
    routecode: json["routecode"],
  );

  Map<String, dynamic> toJson() => {
    "busId": busId,
    "currsegment": currsegment,
    "formattedLastModified": formattedLastModified,
    "heading": heading,
    "lastModified": lastModified,
    "latitude": latitude,
    "longitude": longitude,
    "remainonsegment": remainonsegment,
    "routecode": routecode,
  };
}
