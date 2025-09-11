import 'package:flutter/material.dart';
import 'package:nobetci_eczane_app/constants/app_colors.dart';
import 'package:nobetci_eczane_app/constants/app_strings.dart';
import 'package:nobetci_eczane_app/model/pharmacy_model.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({super.key, required Pharmacy? pharmacy}) : _pharmacy = pharmacy;

  final Pharmacy? _pharmacy;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(foregroundColor: AppColors.blackColor),
      onPressed: () {
        final phone = _pharmacy?.phone ?? '';
        final address = _pharmacy?.address ?? '';
        final name = _pharmacy?.name ?? '';
        final shareText = [
          AppStrings.shareTextTitle,
          "${AppStrings.shareTextName}$name",
          "${AppStrings.shareTextPhone}$phone",
          "${AppStrings.shareTextAddress}$address",
          "${AppStrings.shareTextLocation}${AppStrings.googleMapApiText}${_pharmacy?.loc}",
        ].join('\n');
        SharePlus.instance.share(ShareParams(text: shareText));
      },
      label: Text(AppStrings.shareButtonText),
      icon: Icon(Icons.share_outlined),
    );
  }
}
