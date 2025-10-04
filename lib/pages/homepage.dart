import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nobetci_eczane_app/components/location_button.dart';
import 'package:nobetci_eczane_app/components/pharmacy_button.dart';
import 'package:nobetci_eczane_app/components/pharmacy_card.dart';
import 'package:nobetci_eczane_app/constants/app_colors.dart';
import 'package:nobetci_eczane_app/constants/app_paddings.dart';
import 'package:nobetci_eczane_app/constants/app_radius.dart';
import 'package:nobetci_eczane_app/constants/app_strings.dart';
import 'package:nobetci_eczane_app/constants/assets_paths.dart';
import 'package:nobetci_eczane_app/model/homepage_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends HomepageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: SizedBox(height: 150, child: Image.asset(AssetsPaths.homePageLogoPath)),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Padding(
                  padding: AppPaddings.horizontalNormalPadding + AppPaddings.topSmallPadding,
                  child: Container(
                    decoration: BoxDecoration(borderRadius: AppRadius.normalRadius, color: AppColors.whiteColor),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButton<String>(
                                dropdownColor: AppColors.whiteColor,
                                padding: AppPaddings.horizontalNormalPadding,
                                isExpanded: true,
                                value: selectedCity,
                                hint: Text(AppStrings.provinceDropDownHintText),
                                items: cityData.keys.map((city) {
                                  return DropdownMenuItem(value: city, child: Text(city));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedCity = value;
                                    selectedDistrict = null;
                                  });
                                },
                              ),
                            ),
                            selectedCity == null
                                ? SizedBox.shrink()
                                : IconButton(
                                    onPressed: () => cleanDropDownCity(),
                                    icon: Icon(Icons.cleaning_services_outlined),
                                  ),
                          ],
                        ),
                        selectedCity == null
                            ? SizedBox.shrink()
                            : Row(
                                children: [
                                  Expanded(
                                    child: DropdownButton<String>(
                                      dropdownColor: AppColors.whiteColor,
                                      padding: AppPaddings.horizontalNormalPadding,
                                      isExpanded: true,
                                      value: selectedDistrict,
                                      hint: Text(AppStrings.districtDropDownHintText),
                                      items: selectedCity == null
                                          ? []
                                          : cityData[selectedCity]!.map((district) {
                                              return DropdownMenuItem(value: district, child: Text(district));
                                            }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedDistrict = value;
                                        });
                                      },
                                    ),
                                  ),
                                  selectedDistrict == null
                                      ? SizedBox.shrink()
                                      : IconButton(
                                          onPressed: () => cleanDropDownDistrict(),
                                          icon: Icon(Icons.cleaning_services_outlined),
                                        ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PharmacyButton(
                      city: selectedCity ?? AppStrings.emptyString,
                      district: selectedDistrict ?? AppStrings.emptyString,
                      onPressed: (city, district) {
                        getPharmacy(city, district).then((_) async {
                          if (await isSelectionMatchesCurrentLocation()) {
                            await markClosestPharmacy();
                          } else {
                            setState(() {
                              closestPharmacyIndex = null;
                            });
                          }
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    LocationPharmacyButton(onPressed: () => setCityDistrictFromLocaiton()),
                  ],
                ),
              ],
            ),
            pharmacys != null ? Divider(color: AppColors.lightBlackColor) : SizedBox.shrink(),
            isLoading
                ? Expanded(
                    child: Center(child: SpinKitFadingCircle(color: AppColors.blackColor, size: 90)),
                  )
                : Expanded(
                    child: pharmacys == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 250, child: showLottie(AssetsPaths.pharmacyLottiePath)),
                              Text(
                                AppStrings.firstOpenText,
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        : ListView.builder(
                            itemCount: pharmacys?.length,
                            itemBuilder: (context, index) {
                              return PharmacyCard(
                                pharmacy: pharmacys?[index],
                                isClosest: closestPharmacyIndex != null && closestPharmacyIndex == index,
                              );
                            },
                          ),
                  ),
            Container(color: AppColors.primaryColor, height: 20),
          ],
        ),
      ),
    );
  }
}
