import 'package:go_router/go_router.dart';
import 'package:star_book_refactory/presentation/pages/mood/mood_page.dart';

import '../../app.dart';
import '../pages/home/home_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(routes: [
    GoRoute(path: '/',
    builder: (context, state) => const HomePage(),
    ),
    GoRoute(path: '/mood',
      builder: (context, state) => const MoodPage(),
    )
  ]);
}