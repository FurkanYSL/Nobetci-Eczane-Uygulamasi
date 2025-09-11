import 'package:flutter/material.dart';
import 'package:nobetci_eczane_app/constants/app_colors.dart';
import 'package:nobetci_eczane_app/constants/app_radius.dart';
import 'package:nobetci_eczane_app/constants/app_strings.dart';

class LocationPharmacyButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LocationPharmacyButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.whiteColor,
        textStyle: const TextStyle(fontSize: 15),
        foregroundColor: AppColors.blackColor,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.normalRadius),
        side: BorderSide(color: AppColors.lightBlackColor),
      ),
      child: Text(AppStrings.locationPharmacyButtonText),
    );
  }
}
