import 'package:json_annotation/json_annotation.dart';

part 'pharmacy_model.g.dart';

@JsonSerializable()
class Pharmacy {
  String? name;
  String? dist;
  String? address;
  String? phone;
  String? loc;

  Pharmacy({this.name, this.dist, this.address, this.phone, this.loc});

  Pharmacy.fromJson(Map<String, dynamic> json) {
    _$PharmacyFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PharmacyToJson(this);
  }
}
