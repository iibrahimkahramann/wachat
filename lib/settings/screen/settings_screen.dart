import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wadual/widgets/custom_appbar.dart';
import 'package:wadual/widgets/custom_navbar.dart';
import 'package:url_launcher/link.dart';

import '../../config/custom_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding:
            EdgeInsets.fromLTRB(width * 0.041, height * 0.01, width * 0.041, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width * 0.95,
              height: height * 0.18,
              decoration: BoxDecoration(
                color: Colors.green,
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
                    'Upgrade to Premium',
                    style: TextStyle(
                        fontSize:
                            CustomTheme.textTheme(context).bodyLarge!.fontSize,
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
                    'Join us to benefit from privileges',
                    style: TextStyle(
                        fontSize:
                            CustomTheme.textTheme(context).bodyMedium!.fontSize,
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
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.07,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Link(
                uri: Uri.parse(
                    'https://sites.google.com/view/instory-privacy-policy-home/ana-sayfa'),
                builder: (context, followLink) => Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: followLink,
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      'Privacy Policy',
                      style: CustomTheme.textTheme(context)
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                      textAlign: TextAlign.left, // Metni sola hizalar
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
                horizontal: width * 0.07,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Link(
                uri: Uri.parse(
                    'https://sites.google.com/view/instory-privacy-policy-home/ana-sayfa'),
                builder: (context, followLink) => Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: followLink,
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      'Terms of Use',
                      style: CustomTheme.textTheme(context)
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                      textAlign: TextAlign.left, // Metni sola hizalar
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
                horizontal: width * 0.07,
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
                    child: Text(
                      'Subscriptions',
                      style: CustomTheme.textTheme(context)
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                      textAlign: TextAlign.left, // Metni sola hizalar
                    ),
                  ),
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
