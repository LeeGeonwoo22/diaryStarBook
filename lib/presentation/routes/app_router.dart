import 'package:go_router/go_router.dart';
import 'package:star_book_refactory/domain/models/journal.dart';
import 'package:star_book_refactory/presentation/pages/mood/mood_page.dart';

import '../../app.dart';
import '../pages/home/home_page.dart';
import '../pages/home/home_shell.dart';
import '../pages/journal/journal_detail_page.dart';
import '../pages/journal/journal_page.dart';
import '../pages/settings/settings_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
      initialLocation: '/home',
      routes: [
        ShellRoute(builder:
        (context, state, child) {
          return HomeShell(child : child);
        },
          routes: [
            GoRoute(
              path: '/home', // ✅ 이게 반드시 있어야 합니다
              builder: (context, state) => const HomePage(),
            ),
            GoRoute(path: '/mood',
              builder: (context, state) => const MoodPage(),
            ),
            GoRoute(
              path: '/journal',
              builder: (context, state) => const JournalPage(),
            ),
            GoRoute(
              path: '/journal/detail',
              builder: (context, state) {
                final journal = state.extra as Journal;
                return JournalDetailPage(journal: journal,);
              } ,
            ),
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsPage(),
            ),
          ]
        )
  ]);
}