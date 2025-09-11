import 'package:flutter/material.dart';
import 'package:nobetci_eczane_app/components/call_pharmacy_button.dart';
import 'package:nobetci_eczane_app/components/go_location_button.dart';
import 'package:nobetci_eczane_app/components/share_button.dart';
import 'package:nobetci_eczane_app/constants/app_colors.dart';
import 'package:nobetci_eczane_app/constants/app_paddings.dart';
import 'package:nobetci_eczane_app/constants/app_radius.dart';
import 'package:nobetci_eczane_app/constants/app_strings.dart';
import 'package:nobetci_eczane_app/constants/assets_paths.dart';
import 'package:nobetci_eczane_app/model/pharmacy_model.dart';

class PharmacyCard extends StatelessWidget {
  const PharmacyCard({super.key, required Pharmacy? pharmacy, bool isClosest = false})
    : _pharmacy = pharmacy,
      _isClosest = isClosest;

  final Pharmacy? _pharmacy;
  final bool _isClosest;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.normalRadius,
        side: BorderSide(color: AppColors.lightBlackColor),
      ),
      margin: AppPaddings.allNormalPadding,
      elevation: 5,
      shadowColor: AppColors.blackColor,
      color: AppColors.whiteColor,
      child: Padding(
        padding: AppPaddings.allSmallPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isClosest)
              Padding(
                padding: AppPaddings.bottomSmallPadding,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.redColor,
                    borderRadius: AppRadius.normalRadius,
                    border: Border.all(color: AppColors.blackColor),
                  ),
                  padding: AppPaddings.horizontalNormalPadding + AppPaddings.verticalNormalPadding,
                  child: Text(
                    AppStrings.closestPharmacyText,
                    style: TextStyle(color: AppColors.whiteColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            Padding(
              padding: AppPaddings.horizontalLargePadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 50, width: 50, child: Image.asset(AssetsPaths.pharmacyLogoPath)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(_pharmacy?.name ?? AppStrings.noDataText, style: TextStyle(fontSize: 20)),
                        ),
                        Text(_pharmacy?.dist ?? AppStrings.noDataText, style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: AppPaddings.horizontalLargePadding,
              child: Text(
                _pharmacy?.address ?? AppStrings.noDataText,
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _pharmacy?.phone != null ? CallPharmacyButton(pharmacy: _pharmacy) : SizedBox.shrink(),
                Container(height: 20, width: 1, color: AppColors.blackColor),
                _pharmacy?.loc != null ? GoLocationButton(pharmacy: _pharmacy) : SizedBox.shrink(),
                Container(height: 20, width: 1, color: AppColors.blackColor),
                _pharmacy?.loc != null && _pharmacy?.phone != null
                    ? ShareButton(pharmacy: _pharmacy)
                    : SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
