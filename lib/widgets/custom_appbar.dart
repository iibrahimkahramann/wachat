import 'dart:io';

import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wadual/config/custom_theme.dart';
import 'package:wadual/providers/premium_provider.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isPremium = ref.watch(isPremiumProvider);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: SafeArea(
        child: SizedBox(
          height: kToolbarHeight,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: height * 0.02,
                ),
                child: Image.asset(
                  'assets/logos/logo.png',
                  height: height * 0.029,
                ),
              ),
              SizedBox(
                width: width * 0.33,
              ),
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
                    height: height * 0.045,
                    margin: EdgeInsets.only(right: height * 0.004),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 52, 168, 83),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.06,
                              vertical: height * 0.002),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'PRO',
                              style: CustomTheme.textTheme(context)
                                  .bodyMedium
                                  ?.copyWith(
                                      color: Color.fromARGB(255, 52, 168, 83),
                                      fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
