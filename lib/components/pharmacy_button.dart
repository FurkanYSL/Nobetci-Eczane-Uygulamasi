import 'package:flutter/material.dart';
import 'package:nobetci_eczane_app/constants/app_colors.dart';
import 'package:nobetci_eczane_app/constants/app_radius.dart';
import 'package:nobetci_eczane_app/constants/app_strings.dart';

class PharmacyButton extends StatelessWidget {
  final String city;
  final String district;
  final void Function(String city, String district) onPressed;

  const PharmacyButton({super.key, required this.city, required this.district, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(city, district),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.whiteColor,
        textStyle: const TextStyle(fontSize: 15),
        foregroundColor: AppColors.blackColor,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.normalRadius),
        side: BorderSide(color: AppColors.lightBlackColor),
      ),
      child: Text(AppStrings.pharmacyButtonText),
    );
  }
}
