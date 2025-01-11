import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../config/custom_theme.dart';
import '../providers/qr_code_generator_provider.dart';

class QRGeneratorScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final lastQRCode = ref.watch(qrCodeProvider.notifier).getLastQRCode();
    final TextEditingController _controller = TextEditingController();

    void _generateQRCode() {
      if (_controller.text.isNotEmpty) {
        ref.read(qrCodeProvider.notifier).addQRCode(_controller.text);
        _controller.clear();
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => GoRouter.of(context).go('/home'),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: width * 0.16),
          child: Text(
            'QR Generator',
            style: CustomTheme.textTheme(context)
                .bodyLarge
                ?.copyWith(color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.list, color: Colors.black),
            onPressed: () => GoRouter.of(context).go('/qr-code-list'),
          ),
        ],
        backgroundColor: Colors.grey[300],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            width * 0.041, height * 0.025, width * 0.041, 0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Text',
                labelStyle: TextStyle(
                  fontSize: CustomTheme.textTheme(context).bodyMedium!.fontSize,
                  fontFamily:
                      CustomTheme.textTheme(context).bodyMedium!.fontFamily,
                  fontWeight:
                      CustomTheme.textTheme(context).bodyMedium!.fontWeight,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            GestureDetector(
              onTap: () {
                _generateQRCode();
              },
              child: Container(
                width: width * 0.95,
                height: height * 0.07,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Generate QR Code',
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
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            if (lastQRCode != null) // Eğer son QR kodu varsa göster
              Column(
                children: [
                  QrImageView(
                    data: lastQRCode, // Son QR kodunu göster
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  SizedBox(height: 8),
                  Text(lastQRCode), // Son QR kod metni
                ],
              ),
          ],
        ),
      ),
    );
  }
}
