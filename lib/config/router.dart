import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wadual/screen/emoji_screen.dart';
import 'package:wadual/screen/private_note_screen.dart';
import 'package:wadual/screen/sticker_screen.dart';
import '../screen/home_screen.dart';
import '../screen/private_browser.dart';
import '../screen/qr_code_detail_screen.dart';
import '../screen/qr_code_list_screen.dart';
import '../screen/qr_reader_screen.dart';
import '../screen/qr_generator_screen.dart';
import '../screen/scanned_qr_codes_screen.dart';
import '../screen/settings_screen.dart';
import '../screen/note_list_screen.dart';
import '../screen/note_detail_screen.dart';
import '../screen/splash_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: SplashScreen()),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: HomeScreen()),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: SettingsScreen()),
    ),
    GoRoute(
      path: '/qr-reader',
      name: 'qr reader',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: QRReaderScreen()),
    ),
    GoRoute(
      path: '/qr-generator',
      name: 'qr generator',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: QRGeneratorScreen()),
    ),
    GoRoute(
      path: '/qr-code-list',
      name: 'qr code list',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: QRCodeListScreen()),
    ),
    GoRoute(
      path: '/qr-code-detail',
      name: 'qr code detail',
      pageBuilder: (context, state) {
        final qrCode = state.extra as String;
        return NoTransitionPage(child: QRCodeDetailScreen(qrCode: qrCode));
      },
    ),
    GoRoute(
      path: '/private-note',
      name: 'private note',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: PrivateNoteScreen()),
    ),
    GoRoute(
      path: '/note-list',
      builder: (context, state) => NoteListScreen(),
    ),
    GoRoute(
      path: '/note-detail/:index',
      builder: (context, state) {
        final index = int.parse(state.pathParameters['index']!);
        return NoteDetailScreen(noteIndex: index);
      },
    ),
    GoRoute(
      path: '/private-browser',
      name: 'private browser',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: PrivateBrowserScreen()),
    ),
    GoRoute(
      path: '/emoji',
      name: 'emoji',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: EmojiListScreen()),
    ),
    GoRoute(
      path: '/sticker',
      name: 'sticker',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: StickerListScreen()),
    ),
    GoRoute(
      path: '/scanned-qr-codes',
      name: 'scanned qr codes',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: ScannedQRCodesScreen()),
    ),
  ],
);
