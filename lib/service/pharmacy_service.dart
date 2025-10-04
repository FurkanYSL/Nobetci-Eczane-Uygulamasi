import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nobetci_eczane_app/model/pharmacy_model.dart';

class PharmacyService {
  final Dio dio;
  static const String _baseUrl = "https://api.collectapi.com/health/dutyPharmacy";
  PharmacyService()
    : dio = Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          headers: {"authorization": "${dotenv.env['API_KEY']}", "content-type": "application/json"},
        ),
      );

  Future<List<Pharmacy>?> getPharmacy(String province, String district) async {
    final response = await dio.get("", queryParameters: {"ilce": district, "il": province});
    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data["result"];
      if (datas is List) {
        return datas.map((e) => Pharmacy.fromJson(e)).toList();
      }
    }
    return null;
  }
}
