import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wadual/bar/custom_appbar.dart';
import 'package:wadual/bar/custom_navbar.dart';
import 'package:wadual/config/custom_theme.dart';
import 'package:wadual/firebase/firebase_analytics.dart';
import 'package:wadual/home/controller/home_controller.dart';
import 'package:wadual/providers/premium_provider.dart';

class HomeScreeen extends ConsumerStatefulWidget {
  const HomeScreeen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends ConsumerState<HomeScreeen> {
  bool hasSeenPaywall = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(const Duration(seconds: 0), () {
        if (!hasSeenPaywall) {
          checkAndRequestReview();

          hasSeenPaywall = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isPremium = ref.watch(isPremiumProvider);

    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.fromLTRB(width * 0.041, height * 0.01, width * 0.041, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: height * 0.31,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset('assets/images/home_background.png'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.02),
                  child: Column(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/logos/home_logo.png',
                          width: width * 0.17,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      Text(
                        'Web Messanger',
                        style: CustomTheme.textTheme(context).bodyLarge,
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                        child: Text(
                            'Login to your Web Messanger second account with Wachat',
                            textAlign: TextAlign.center,
                            style: CustomTheme.textTheme(context).bodyMedium),
                      ),
                      SizedBox(
                        height: height * 0.015,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (!isPremium) {
                            final profile = await Adapty().getProfile();
                            final isPremium =
                                profile.accessLevels['premium']?.isActive ??
                                    false;

                            ref
                                .read(isPremiumProvider.notifier)
                                .updatePremiumStatus(isPremium);

                            if (isPremium) {
                              print(
                                  "Kullanıcı premium, paywall gösterilmeyecek");
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
                          } else {
                            AnalyticsService.analytics
                                .logEvent(name: 'Wachat Giriş');
                            context.go('/wachat');
                          }
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: Container(
                            height: height * 0.06,
                            width: width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color.fromARGB(255, 37, 211, 102)),
                            child: Center(
                              child: Text('Open Web Messenger',
                                  style: CustomTheme.textTheme(context)
                                      .bodyMedium
                                      ?.copyWith(color: Colors.white)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.005, horizontal: width * 0.04),
              child: Text(
                'FEATURES',
                style: CustomTheme.textTheme(context)
                    .bodyLarge
                    ?.copyWith(fontFamily: ''),
              ),
            ),
            SizedBox(height: height * 0.005),
            GestureDetector(
              onTap: () => context.go('/qr-generator'),
              child: Container(
                width: width,
                height: height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/qr_generator.png',
                        width: width * 0.14,
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'QR Generator',
                            style: CustomTheme.textTheme(context).bodyLarge,
                          ),
                          Text(
                            'Generate QR code',
                            style: CustomTheme.textTheme(context)
                                .bodyMedium
                                ?.copyWith(color: Colors.black.withAlpha(160)),
                          ),
                        ],
                      ),
                      Spacer(), // To push the icon to the end of the row
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.015),
            GestureDetector(
              onTap: () => context.go('/qr-reader'),
              child: Container(
                width: width,
                height: height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/qr_scanner.png',
                        width: width * 0.14,
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'QR Scanner',
                            style: CustomTheme.textTheme(context).bodyLarge,
                          ),
                          Text(
                            'Scan your QR codes',
                            style: CustomTheme.textTheme(context)
                                .bodyMedium
                                ?.copyWith(color: Colors.black.withAlpha(160)),
                          ),
                        ],
                      ),
                      Spacer(), // To push the icon to the end of the row
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.015),
            GestureDetector(
              onTap: () => context.go('/private-note'),
              child: Container(
                width: width,
                height: height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/notes.png',
                        width: width * 0.14,
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Privacy Notes',
                            style: CustomTheme.textTheme(context).bodyLarge,
                          ),
                          Text(
                            'Keep a secret note',
                            style: CustomTheme.textTheme(context)
                                .bodyMedium
                                ?.copyWith(color: Colors.black.withAlpha(160)),
                          ),
                        ],
                      ),
                      Spacer(), // To push the icon to the end of the row
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.015),
            GestureDetector(
              onTap: () => context.go('/private-browser'),
              child: Container(
                width: width,
                height: height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/privacy_browser.png',
                        width: width * 0.14,
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Privacy Browser',
                            style: CustomTheme.textTheme(context).bodyLarge,
                          ),
                          Text(
                            'Use Incognito Browser',
                            style: CustomTheme.textTheme(context)
                                .bodyMedium
                                ?.copyWith(color: Colors.black.withAlpha(160)),
                          ),
                        ],
                      ),
                      Spacer(), // To push the icon to the end of the row
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.015),
            GestureDetector(
              onTap: () => context.go('/emoji'),
              child: Container(
                width: width,
                height: height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/emojis.png',
                        width: width * 0.14,
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Emojis',
                            style: CustomTheme.textTheme(context).bodyLarge,
                          ),
                          Text(
                            'More Emoji',
                            style: CustomTheme.textTheme(context)
                                .bodyMedium
                                ?.copyWith(color: Colors.black.withAlpha(160)),
                          ),
                        ],
                      ),
                      Spacer(), // To push the icon to the end of the row
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.015),
            GestureDetector(
              onTap: () => context.go('/sticker'),
              child: Container(
                width: width,
                height: height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/stickers.png',
                        width: width * 0.14,
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Stickers',
                            style: CustomTheme.textTheme(context).bodyLarge,
                          ),
                          Text(
                            'More Sricker',
                            style: CustomTheme.textTheme(context)
                                .bodyMedium
                                ?.copyWith(color: Colors.black.withAlpha(160)),
                          ),
                        ],
                      ),
                      Spacer(), // To push the icon to the end of the row
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.015),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(currentLocation: '/home'),
    );
  }
}
