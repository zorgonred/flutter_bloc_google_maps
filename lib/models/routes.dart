class Routes {
    String name;
    String colour;
    List<Coords> coords;

    Routes({this.name, this.colour, this.coords});

    Routes.fromJson(Map<String, dynamic> json) {
        name = json['name'];
        colour = json['colour'];
        if (json['coords'] != null) {
            coords = new List<Coords>();
            json['coords'].forEach((v) {
                coords.add(new Coords.fromJson(v));
            });
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['name'] = this.name;
        data['colour'] = this.colour;
        if (this.coords != null) {
            data['coords'] = this.coords.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Coords {
    String iD;
    num longitude;
    num latitude;

    Coords({this.iD, this.longitude, this.latitude});

    Coords.fromJson(Map<String, dynamic> json) {
        iD = json['ID'];
        longitude = json['longitude'];
        latitude = json['latitude'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['ID'] = this.iD;
        data['longitude'] = this.longitude;
        data['latitude'] = this.latitude;
        return data;
    }
}