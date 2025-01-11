import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class QRCodeNotifier extends StateNotifier<Map<String, dynamic>> {
  QRCodeNotifier()
      : super({
          "qrCode": "Henüz bir QR kod taranmadı",
          "isCameraActive": false,
          "scannedCodes": []
        }) {
    _loadScannedCodes(); // Uygulama başlatıldığında kaydedilmiş kodları yükle
  }

  Future<void> _loadScannedCodes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? codesString = prefs.getString('scannedCodes');
    if (codesString != null) {
      final List<String> codes = List<String>.from(json.decode(codesString));
      state = {...state, "scannedCodes": codes};
    }
  }

  Future<void> _saveScannedCodes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('scannedCodes', json.encode(state["scannedCodes"]));
  }

  void addScannedCode(String code) {
    final updatedCodes = List<String>.from(state["scannedCodes"] ?? []);
    if (!updatedCodes.contains(code)) {
      updatedCodes.add(code);
      state = {...state, "scannedCodes": updatedCodes};
      _saveScannedCodes(); // Her eklemede kaydet
    }
  }

  void removeScannedCode(String code) {
    final updatedCodes = List<String>.from(state["scannedCodes"] ?? []);
    updatedCodes.remove(code);
    state = {...state, "scannedCodes": updatedCodes};
    _saveScannedCodes(); // Her silmede kaydet
  }

  void toggleCamera() {
    state = {
      ...state,
      "isCameraActive": !state["isCameraActive"]
    }; // Kameranın durumunu değiştir
  }
}

final qrCodeProvider =
    StateNotifierProvider<QRCodeNotifier, Map<String, dynamic>>((ref) {
  return QRCodeNotifier();
});
