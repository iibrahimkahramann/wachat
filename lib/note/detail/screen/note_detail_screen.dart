import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/custom_theme.dart';
import '../../../providers/note_provider.dart';

class NoteDetailScreen extends ConsumerWidget {
  final int noteIndex; // Güncellenecek notun indeksi

  NoteDetailScreen({required this.noteIndex}); // Yapıcı metod

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final note = ref.watch(noteProvider)[noteIndex]; // Notu al
    final TextEditingController _titleController =
        TextEditingController(text: note.title);
    final TextEditingController _textController =
        TextEditingController(text: note.text);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/icons/chevron-left.png',
              width: width * 0.06, color: Colors.black),
          onPressed: () => GoRouter.of(context).go('/note-list'),
        ),
        title: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.17),
          child: Text(
            'Note Detail',
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
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'Not Başlığını güncelleyin...',
                  hintStyle: CustomTheme.textTheme(context).bodySmall),
            ),
            SizedBox(height: height * 0.02),
            TextField(
              controller: _textController,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Not metnini güncelleyin...',
                hintStyle: CustomTheme.textTheme(context)
                    .bodyMedium
                    ?.copyWith(color: Colors.grey[400]),
              ),
            ),
            SizedBox(height: height * 0.02),
            GestureDetector(
              onTap: () {
                // Notu güncelle
                ref
                    .read(noteProvider.notifier)
                    .deleteNote(noteIndex); // Önce mevcut notu sil
                ref.read(noteProvider.notifier).addNote(
                      _titleController.text,
                      _textController.text,
                    );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Not güncellendi!')), // Güncelleme mesajı
                );
                context.go('/note-list'); // Not listesine geri dön
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
                    'Notu Güncelle',
                    style: CustomTheme.textTheme(context)
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
