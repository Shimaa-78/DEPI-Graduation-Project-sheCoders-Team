class OnBoardingModel {
  String imagePath;
  String title;
  String Discreption;
  OnBoardingModel(
      {required this.imagePath,
      required this.title,
      required this.Discreption});
}

List<OnBoardingModel> OnboardingList = [
  OnBoardingModel(
      imagePath: "assets/images/onboarding1.jpg",
      title: "Hello",
      Discreption:
          "Browse through a wide range of products across various categories and find exactly what you're looking for."),
  OnBoardingModel(
      imagePath: "assets/images/Placeholder_01.png",
      title: "Fast Delivery",
      Discreption:
"Get your orders delivered quickly to your doorstep, with real-time tracking available for your convenience."
  ),
  OnBoardingModel(
      imagePath: "assets/images/onboarding3.jpg",
      title: "Exclusive Offers",
      Discreption:
      "Unlock special deals, discounts, and exclusive offers available only to our app users."
  ),
  OnBoardingModel(
      imagePath: "assets/images/onboarding4.jpg",
      title: "Rready!",
      Discreption:
      "Let's Start"
  ),
];
