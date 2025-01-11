import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note_model.dart';

class NoteNotifier extends StateNotifier<List<Note>> {
  NoteNotifier() : super([]) {
    _loadNotes(); // Uygulama başlatıldığında notları yükle
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedNotes = prefs.getStringList('notes');

    // Debugging: savedNotes içeriğini kontrol et
    print('Saved Notes: $savedNotes');

    // Eğer savedNotes null veya boşsa, state'i boş bir liste olarak ayarlayın
    if (savedNotes == null || savedNotes.isEmpty) {
      state = [];
      return; // Fonksiyondan çık
    }

    // Kaydedilen notları duruma ata
    state = savedNotes.map((note) {
      final Map<String, String> noteJson = Map<String, String>.from(
          jsonDecode(note)); // JSON'dan not modeline dönüştür
      return Note.fromJson(noteJson);
    }).toList();
  }

  Future<void> addNote(String title, String text) async {
    final newNote = Note(title: title, text: text);
    state = [...state, newNote]; // Yeni notu ekle
    final prefs = await SharedPreferences.getInstance();

    // Notları JSON formatında kaydet
    await prefs.setStringList(
        'notes', state.map((note) => jsonEncode(note.toJson())).toList());

    // Debugging: Kaydedilen notları kontrol et
    print('Notes saved: ${state.map((note) => note.toJson())}');
  }

  Future<void> deleteNote(int index) async {
    state = [...state]..removeAt(index); // Belirtilen indeksteki notu sil
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'notes',
        state
            .map((note) => jsonEncode(note.toJson()))
            .toList()); // Güncellenmiş notları kaydet
  }
}

final noteProvider = StateNotifierProvider<NoteNotifier, List<Note>>((ref) {
  return NoteNotifier();
});
