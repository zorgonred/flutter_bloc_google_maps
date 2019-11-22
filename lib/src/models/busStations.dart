
class BusStations {


    num longitude;
    num latitude;
    String short_name;
    String code;
    num sort;

    BusStations({this.longitude, this.latitude, this.short_name, this.code, this.sort});

    factory BusStations.fromJson(Map<String, dynamic> json) {
        return  BusStations(
            longitude: json['longitude'] as num,
            latitude: json['longitude'] as num,
            short_name: json['short_name'] as String,
            code: json['code'] as String,
            sort: json['sort'] as num,
        );
    }
}