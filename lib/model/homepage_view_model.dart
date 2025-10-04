import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:nobetci_eczane_app/constants/assets_paths.dart';
import 'package:nobetci_eczane_app/model/pharmacy_model.dart';
import 'package:nobetci_eczane_app/pages/homepage.dart';
import 'package:nobetci_eczane_app/service/location_service.dart';
import 'package:nobetci_eczane_app/service/pharmacy_service.dart';

abstract class HomepageViewModel extends State<HomePage> {
  final PharmacyService service = PharmacyService();
  final LocationService locationService = LocationService();
  List<Pharmacy>? pharmacys;
  bool isLoading = false;
  Map<String, List<String>> cityData = {};
  String? selectedCity;
  String? selectedDistrict;
  int? closestPharmacyIndex;

  Future<void> getPharmacy(String province, String district) async {
    changeLoading();
    pharmacys = await service.getPharmacy(province, district);
    closestPharmacyIndex = null;
    changeLoading();
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Widget showLottie(String lottiePath) {
    return Lottie.asset(lottiePath);
  }

  Future<void> loadCityData() async {
    final String cityDistrictJson = await rootBundle.loadString(AssetsPaths.provinceDistrictJsonPath);
    final Map<String, dynamic> jsonMap = jsonDecode(cityDistrictJson);
    setState(() {
      cityData = jsonMap.map((key, value) => MapEntry(key, List<String>.from(value)));
    });
  }

  Future<void> setCityDistrictFromLocaiton() async {
    final location = await locationService.getCurrentCityDistrict();

    if (location != null && location[JsonSpaces.city.value] != null && location[JsonSpaces.district.value] != null) {
      final city = location[JsonSpaces.city.value];
      var district = location[JsonSpaces.district.value];

      if (district!.contains(JsonSpaces.space.value)) {
        district = district.split(JsonSpaces.space.value).last;
      }

      if (!cityData[city]!.contains(district)) {
        district = null;
      }

      setState(() {
        selectedCity = city;
        selectedDistrict = district;
      });
      if (selectedDistrict != null) {
        await getPharmacy(selectedCity!, selectedDistrict!);
        await markClosestPharmacy();
      }
    }
  }

  Future<void> markClosestPharmacy() async {
    if (pharmacys == null || pharmacys!.isEmpty) return;

    final currentPos = await locationService.getCurrentPosition();
    if (currentPos == null) return;

    double? minDistanceMeters;
    int? minIndex;

    for (int i = 0; i < pharmacys!.length; i++) {
      final pharmacy = pharmacys![i];
      final loc = pharmacy.loc;
      if (loc == null || loc.isEmpty) continue;

      final parts = loc.split(JsonSpaces.comma.value);
      if (parts.length != 2) continue;
      final lat = double.tryParse(parts[0].trim());
      final lon = double.tryParse(parts[1].trim());
      if (lat == null || lon == null) continue;

      final distance = Geolocator.distanceBetween(currentPos.latitude, currentPos.longitude, lat, lon);
      if (minDistanceMeters == null || distance < minDistanceMeters) {
        minDistanceMeters = distance;
        minIndex = i;
      }
    }

    if (minIndex != null) {
      setState(() {
        closestPharmacyIndex = minIndex;
      });
    }
  }

  Future<bool> isSelectionMatchesCurrentLocation() async {
    if (selectedCity == null) return false;

    final location = await locationService.getCurrentCityDistrict();
    if (location == null) return false;

    String? city = location[JsonSpaces.city.value];
    String? district = location[JsonSpaces.district.value];

    if (district!.contains(JsonSpaces.space.value)) {
      district = district.split(JsonSpaces.space.value).last;
    }

    if (selectedCity!.trim() != city?.trim()) return false;

    if (selectedDistrict == null) return true;

    return selectedDistrict!.trim() == district.trim();
  }

  void cleanDropDownCity() {
    if (selectedCity != null) {
      setState(() {
        selectedCity = null;
        pharmacys = null;
        closestPharmacyIndex = null;
      });
    }
  }

  void cleanDropDownDistrict() {
    if (selectedDistrict != null) {
      setState(() {
        selectedDistrict = null;
        pharmacys = null;
        closestPharmacyIndex = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadCityData();
  }
}

enum JsonSpaces { city, district, space, comma }

extension JsonSpacesExtension on JsonSpaces {
  String get value {
    switch (this) {
      case JsonSpaces.city:
        return "city";
      case JsonSpaces.district:
        return "district";
      case JsonSpaces.space:
        return " ";
      case JsonSpaces.comma:
        return ",";
    }
  }
}
