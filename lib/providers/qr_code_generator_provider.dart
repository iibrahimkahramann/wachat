import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRCodeNotifier extends StateNotifier<List<String>> {
  QRCodeNotifier() : super([]) {
    _loadQRcodes(); // Uygulama başlatıldığında QR kodlarını yükle
  }

  void addQRCode(String code) {
    state = [...state, code]; // Yeni QR kodunu ekle
    _saveQRcodes(); // QR kodlarını kaydet
  }

  Future<void> _loadQRcodes() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedQRcodes = prefs.getStringList('qrCodes');
    if (savedQRcodes != null) {
      state = savedQRcodes; // Kaydedilen QR kodlarını duruma ata
    }
  }

  Future<void> _saveQRcodes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('qrCodes', state); // QR kodlarını kaydet
  }

  String? getLastQRCode() {
    return state.isNotEmpty ? state.last : null; // Son QR kodunu döndür
  }
}

final qrCodeProvider =
    StateNotifierProvider<QRCodeNotifier, List<String>>((ref) {
  return QRCodeNotifier();
});
