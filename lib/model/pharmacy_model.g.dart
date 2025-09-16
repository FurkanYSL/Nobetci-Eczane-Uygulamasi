// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pharmacy _$PharmacyFromJson(Map<String, dynamic> json) => Pharmacy(
  name: json['name'] as String?,
  dist: json['dist'] as String?,
  address: json['address'] as String?,
  phone: json['phone'] as String?,
  loc: json['loc'] as String?,
);

Map<String, dynamic> _$PharmacyToJson(Pharmacy instance) => <String, dynamic>{
  'name': instance.name,
  'dist': instance.dist,
  'address': instance.address,
  'phone': instance.phone,
  'loc': instance.loc,
};
