import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> checkAndRequestReview() async {
  final InAppReview inAppReview = InAppReview.instance;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool hasRated = prefs.getBool('hasRated') ?? false;

  if (!hasRated) {
    try {
      final isAvailable = await inAppReview.isAvailable();
      if (isAvailable) {
        await inAppReview.requestReview();
        prefs.setBool('hasRated', true);
      } else {
        print('In-app review is not available');
      }
    } catch (e) {
      print('Error requesting review: $e');
    }
  }
}

Future<void> homePaywall() async {
  try {
    final paywall = await Adapty().getPaywall(
      placementId: 'placement-onboarding',
      locale: 'en',
    );

    final view = await AdaptyUI().createPaywallView(
      paywall: paywall,
    );
    await view.present();
  } on AdaptyError catch (e) {
    print("Adapty hatası: $e");
  } catch (e) {
    print("Beklenmeyen hata: $e");
  }
}
