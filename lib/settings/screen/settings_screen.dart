import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:lottie/lottie.dart';
import 'package:wadual/providers/premium_provider.dart';
import 'package:wadual/bar/custom_appbar.dart';
import 'package:wadual/bar/custom_navbar.dart';
import 'package:url_launcher/link.dart';

import '../../config/custom_theme.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isPremium = ref.watch(isPremiumProvider);

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding:
            EdgeInsets.fromLTRB(width * 0.041, height * 0.01, width * 0.041, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isPremium)
              GestureDetector(
                onTap: () async {
                  final profile = await Adapty().getProfile();
                  final isPremium =
                      profile.accessLevels['premium']?.isActive ?? false;

                  ref
                      .read(isPremiumProvider.notifier)
                      .updatePremiumStatus(isPremium);

                  if (isPremium) {
                    print("Kullanıcı premium, paywall gösterilmeyecek");
                    return;
                  }

                  final paywall = await Adapty().getPaywall(
                    placementId: 'placement-pro',
                    locale: 'en',
                  );

                  final view = await AdaptyUI().createPaywallView(
                    paywall: paywall,
                  );
                  await view.present();
                },
                child: Container(
                  width: width * 0.95,
                  height: height * 0.18,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 52, 168, 83),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Lottie.asset(
                        'assets/icons/premium.json',
                        width: width * 0.20,
                      ),
                      SizedBox(
                        height: height * 0.0001,
                      ),
                      Text(
                        'Upgrade to Premium'.tr(),
                        style: TextStyle(
                            fontSize: CustomTheme.textTheme(context)
                                .bodyLarge!
                                .fontSize,
                            fontFamily: CustomTheme.textTheme(context)
                                .bodyLarge!
                                .fontFamily,
                            fontWeight: CustomTheme.textTheme(context)
                                .bodyLarge!
                                .fontWeight,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: height * 0.004,
                      ),
                      Text(
                        'Join us to benefit from privileges'.tr(),
                        style: TextStyle(
                            fontSize: CustomTheme.textTheme(context)
                                .bodyMedium!
                                .fontSize,
                            fontFamily: CustomTheme.textTheme(context)
                                .bodyMedium!
                                .fontFamily,
                            fontWeight: CustomTheme.textTheme(context)
                                .bodyMedium!
                                .fontWeight,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Link(
                uri: Uri.parse(
                    'https://sites.google.com/view/wachat-privacy/ana-sayfa'),
                builder: (context, followLink) => Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: followLink,
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.zero,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/privacy.png',
                          width: width * 0.08,
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          'Privacy Policy'.tr(),
                          style: CustomTheme.textTheme(context)
                              .bodyMedium
                              ?.copyWith(color: Colors.black),
                          textAlign: TextAlign.left, // Metni sola hizalar
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Link(
                uri: Uri.parse(
                    'https://sites.google.com/view/wachat-terms/ana-sayfa'),
                builder: (context, followLink) => Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: followLink,
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.zero,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/terms.png',
                          width: width * 0.08,
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          'Terms of Use'.tr(),
                          style: CustomTheme.textTheme(context)
                              .bodyMedium
                              ?.copyWith(color: Colors.black),
                          textAlign: TextAlign.left, // Metni sola hizalar
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Link(
                uri: Uri.parse(
                    'https://myaccount.google.com/intro/payments-and-subscriptions'),
                builder: (context, followLink) => Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: followLink,
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.zero,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/subscriptions.png',
                          width: width * 0.08,
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          'Subscriptions'.tr(),
                          style: CustomTheme.textTheme(context)
                              .bodyMedium
                              ?.copyWith(color: Colors.black),
                          textAlign: TextAlign.left, // Metni sola hizalar
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton(
                onPressed: () async {
                  final InAppReview inAppReview = InAppReview.instance;
                  if (await inAppReview.isAvailable()) {
                    await inAppReview.requestReview();
                  } else {
                    print('In-app review is not available');
                  }
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/star.png',
                      width: width * 0.08,
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    Text(
                      'Rate Us'.tr(),
                      style: CustomTheme.textTheme(context)
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(currentLocation: '/settings'),
    );
  }
}
