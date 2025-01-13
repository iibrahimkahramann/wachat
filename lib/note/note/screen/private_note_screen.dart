import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/custom_theme.dart';
import '../../../providers/note_provider.dart';

class PrivateNoteScreen extends ConsumerWidget {
  const PrivateNoteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _noteController = TextEditingController();
    String _title = '';
    String _note = '';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/icons/chevron-left.png',
              width: width * 0.06, color: Colors.black),
          onPressed: () => GoRouter.of(context).go('/home'),
        ),
        title: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.17),
          child: Text(
            'Private Note',
            style: CustomTheme.textTheme(context)
                .bodyLarge
                ?.copyWith(color: Colors.black),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: Image.asset('assets/icons/folder.png',
                  width: width * 0.06, color: Colors.black),
              onPressed: () => GoRouter.of(context).go('/note-list'),
            ),
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
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Not Başlığını buraya yazın...',
                hintStyle: CustomTheme.textTheme(context)
                    .bodyMedium
                    ?.copyWith(color: Colors.grey[400]),
              ),
              onChanged: (value) {
                _title = value;
              },
            ),
            SizedBox(height: height * 0.02),
            TextField(
              controller: _noteController,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Notunuzu buraya yazın...',
                hintStyle: CustomTheme.textTheme(context)
                    .bodyMedium
                    ?.copyWith(color: Colors.grey[400]),
              ),
              onChanged: (value) {
                _note = value;
              },
            ),
            SizedBox(height: height * 0.02),
            GestureDetector(
              onTap: () async {
                if (_title.isNotEmpty && _note.isNotEmpty) {
                  await ref.read(noteProvider.notifier).addNote(_title, _note);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Notunuz kaydedildi!')),
                  );
                  _titleController.clear();
                  _noteController.clear();
                }
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
                    'Notu Kaydet',
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
