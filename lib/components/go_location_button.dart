import 'package:flutter/material.dart';
import 'package:nobetci_eczane_app/constants/app_colors.dart';
import 'package:nobetci_eczane_app/constants/app_strings.dart';
import 'package:nobetci_eczane_app/model/pharmacy_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GoLocationButton extends StatelessWidget {
  const GoLocationButton({super.key, required Pharmacy? pharmacy}) : _pharmacy = pharmacy;

  final Pharmacy? _pharmacy;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(foregroundColor: AppColors.blackColor),
      onPressed: () {
        launchUrlString("${AppStrings.googleMapApiText}${_pharmacy?.loc}", mode: LaunchMode.externalApplication);
      },
      label: Text(AppStrings.locationButtonText),
      icon: Icon(Icons.navigation_outlined),
    );
  }
}
