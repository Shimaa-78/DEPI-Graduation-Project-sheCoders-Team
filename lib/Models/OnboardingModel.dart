import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class OnBoardingModel {
  String imagePath;
  String title;
  String description;

  OnBoardingModel({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

List<OnBoardingModel> getOnboardingList(BuildContext context) {
  return [
    OnBoardingModel(
      imagePath: "assets/images/onboarding1.jpg",
      title: AppLocalizations.of(context)!.hello,
      description: AppLocalizations.of(context)!
          .browse_through_a_wide_range_of_products_across_various_categories_and_find_exactly_what_you_are_looking_for,
    ),
    OnBoardingModel(
      imagePath: "assets/images/Placeholder_01.png",
      title: AppLocalizations.of(context)!.fast_Delivery,
      description: AppLocalizations.of(context)!
          .get_your_orders_delivered_quickly_to_your_doorstep_with_real_time_tracking_available_for_your_convenience,
    ),
    OnBoardingModel(
      imagePath: "assets/images/onboarding3.jpg",
      title: AppLocalizations.of(context)!.exclusive_Offers,
      description: AppLocalizations.of(context)!
          .unlock_special_deals_discounts_and_exclusive_offers_available_only_to_our_app_users,
    ),
    OnBoardingModel(
      imagePath: "assets/images/onboarding4.jpg",
      title: AppLocalizations.of(context)!.ready,
      description: AppLocalizations.of(context)!.let_us_get_started,
    ),
  ];
}
