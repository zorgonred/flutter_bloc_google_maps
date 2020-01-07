class BusStops {
  num Latitude;
  num Longitude;
  String Name;
  num StopNumber;

  BusStops({this.Latitude, this.Longitude, this.Name, this.StopNumber});

  factory BusStops.fromJson(Map<String, dynamic> json) {
    return BusStops(
      Latitude: json['Latitude'] as num,
      Longitude: json['Longitude'] as num,
      Name: json['Name'] as String,
      StopNumber: json['StopNumber'] as num,
    );
  }
}
