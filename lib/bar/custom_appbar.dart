import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
