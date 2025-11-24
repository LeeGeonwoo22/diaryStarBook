import 'package:go_router/go_router.dart';
import 'package:star_book_refactory/domain/models/journal.dart';
import 'package:star_book_refactory/presentation/pages/mood/mood_page.dart';

import '../../app.dart';
import '../pages/home/home_page.dart';
import '../pages/home/home_shell.dart';
import '../pages/journal/screens/journal_detail_page.dart';

import '../pages/journal/journal_page.dart';
import '../pages/journal/screens/journal_edit_page.dart';
import '../pages/settings/settings_page.dart';
import '../pages/signin/email_login.dart';
import '../pages/signin/login.dart';
import '../pages/splash/splash.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
      initialLocation: '/splash',

      routes: [
        GoRoute(path: '/splash',
        builder: (context, state) => const SplashPage()
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
          routes: [
            GoRoute(
              path: 'email-login',
              builder: (context, state) => const EmailLoginPage(),
            ),
          ]
        ),
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
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (context, state) {
                    final journal = state.extra as Journal;
                    return JournalDetailPage(journal: journal,);
                  },
                    routes :[
                      GoRoute(
                        path: 'edit',
                        builder: (context, state) {
                          final journal = state.extra as Journal;
                          return JournalEditPage(journal: journal);
                        },
                      ),
                    ]
                ),

              ]
            ),

            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsPage(),
            ),
          ]
        )
  ]);
}