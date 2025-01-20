import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wadual/config/custom_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivateBrowserScreen extends StatefulWidget {
  @override
  _PrivateBrowserScreenState createState() => _PrivateBrowserScreenState();
}

class _PrivateBrowserScreenState extends State<PrivateBrowserScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(
          JavaScriptMode.unrestricted) // JavaScript'i etkinleştir
      ..clearCache() // Önbelleği temizle
      ..loadRequest(Uri.parse('https://www.google.com'));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/icons/chevron-left.png',
              width: width * 0.06, color: Colors.black),
          onPressed: () => GoRouter.of(context).go('/home'),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: width * 0.13),
          child: Text(
            'Private Browser'.tr(),
            style: CustomTheme.textTheme(context)
                .bodyLarge
                ?.copyWith(color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            onPressed: () {
              _controller.reload(); // Sayfayı yenile
            },
          ),
        ],
        backgroundColor: Colors.grey[300],
      ),
      body: WebViewWidget(
        controller: _controller, // WebViewController atanıyor
      ),
    );
  }
}
