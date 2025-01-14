import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:wadual/home/controller/home_controller.dart';
import 'package:wadual/providers/premium_provider.dart';
import 'package:wadual/widgets/custom_appbar.dart';
import 'package:wadual/widgets/custom_navbar.dart';

import '../../config/custom_theme.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(const Duration(seconds: 5), () {
        checkAndRequestReview();
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
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              width * 0.041, height * 0.01, width * 0.041, 0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  if (!isPremium)
                    context.go('/qr-reader');
                  else
                    homePaywall();
                },
                child: Container(
                  width: width * 0.95,
                  height: height * 0.18,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 52, 168, 83),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/logos/app_icon.png',
                          width: width * 0.2,
                        ),
                        SizedBox(
                          width: width * 0.04,
                        ),
                        Text(
                          'WA 2nd Chat',
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
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Padding(
                padding: EdgeInsets.only(right: width * 0.65),
                child: Text(
                  'Features',
                  style: CustomTheme.textTheme(context)
                      .bodyLarge
                      ?.copyWith(color: Colors.black),
                ),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              GestureDetector(
                onTap: () => context.go('/qr-generator'),
                child: Container(
                  width: width * 0.95,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: height * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/qr_generator.png',
                          width: width * 0.1,
                        ),
                        SizedBox(
                          width: width * 0.07,
                        ),
                        Text(
                          'QR Generator',
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
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              GestureDetector(
                onTap: () => context.go('/qr-reader'),
                child: Container(
                  width: width * 0.95,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: height * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/qr_reader.png',
                          width: width * 0.1,
                        ),
                        SizedBox(
                          width: width * 0.07,
                        ),
                        Text(
                          'QR Reader',
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
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              GestureDetector(
                onTap: () => context.go('/private-note'),
                child: Container(
                  width: width * 0.95,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: height * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/private_note.png',
                          width: width * 0.1,
                        ),
                        SizedBox(
                          width: width * 0.07,
                        ),
                        Text(
                          'Private Note',
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
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              GestureDetector(
                onTap: () => context.go('/private-browser'),
                child: Container(
                  width: width * 0.95,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: height * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/private_browser.png',
                          width: width * 0.1,
                        ),
                        SizedBox(
                          width: width * 0.07,
                        ),
                        Text(
                          'Private Browser',
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
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              GestureDetector(
                onTap: () => context.go('/emoji'),
                child: Container(
                  width: width * 0.95,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: height * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/emoji.png',
                          width: width * 0.1,
                        ),
                        SizedBox(
                          width: width * 0.07,
                        ),
                        Text(
                          'Emojis',
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
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              GestureDetector(
                onTap: () => context.go('/sticker'),
                child: Container(
                  width: width * 0.95,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: height * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/star.png',
                          width: width * 0.1,
                        ),
                        SizedBox(
                          width: width * 0.07,
                        ),
                        Text(
                          'Stickers',
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
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.015,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(currentLocation: '/home'),
    );
  }
}
