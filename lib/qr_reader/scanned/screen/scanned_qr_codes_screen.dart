import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wadual/config/custom_theme.dart';
import '../../../providers/qr_code_reader_provider.dart';

class ScannedQRCodesScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final qrCodeData = ref.watch(qrCodeProvider);
    final scannedCodes = qrCodeData["scannedCodes"] ?? [];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => GoRouter.of(context).go('/home'),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: width * 0.15),
          child: Text(
            'Scanned QR Codes',
            style: CustomTheme.textTheme(context)
                .bodyLarge
                ?.copyWith(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            width * 0.041, height * 0.025, width * 0.041, 0),
        child: scannedCodes.isEmpty
            ? Center(child: Text('No scanned QR codes yet.'))
            : ListView.builder(
                itemCount: scannedCodes.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: height * 0.015),
                    padding: EdgeInsets.all(height * 0.015),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            scannedCodes[index].length > 20
                                ? '${scannedCodes[index].substring(0, 20)}...' // İlk 20 karakter ve "..."
                                : scannedCodes[index], // Tam başlık
                            style: CustomTheme.textTheme(context)
                                .bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            ref
                                .read(qrCodeProvider.notifier)
                                .removeScannedCode(scannedCodes[index]);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('QR code deleted!')),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
