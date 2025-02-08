import 'parents/model.dart';

class Station extends Model {
  Station(
      {this.address,
      this.images,
      this.lat,
      this.lng,
      this.name,
      this.phone,
      this.rate,
      this.availableDurations});

  Station.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    address = stringFromJson(json, 'address');
    images = json?['images'].cast<String>().toList();
    lat = doubleFromJson(json, 'lat');
    lng = doubleFromJson(json, 'lng');
    name = stringFromJson(json, 'name');
    phone = stringFromJson(json, 'phone');
    rate = doubleFromJson(json, 'rate');
    availableDurations =
        listFromJson(json, 'available_duration', (e) => e as Map);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['id'] = id;
    data['images'] = images;
    data['lat'] = lat;
    data['lng'] = lng;
    data['name'] = name;
    data['phone'] = phone;
    data['rate'] = rate;
    data['available_duration'] = availableDurations;
    return data;
  }

  String? address;
  List<String>? images;
  double? lat;
  double? lng;
  String? name;
  String? phone;
  double? rate;
  List<Map>? availableDurations;
}
