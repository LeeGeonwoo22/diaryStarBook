import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeShell extends StatelessWidget {
  final Widget child;
  const HomeShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    int currentIndex = 0;
    if (location.startsWith('/mood')) currentIndex = 1;
    else if (location.startsWith('/journal')) currentIndex = 2;
    else if (location.startsWith('/settings')) currentIndex = 3;

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.indigo,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/mood');
              break;
            case 2:
              context.go('/journal');
              break;
            case 3:
              context.go('/settings');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈', backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(Icons.mood), label: '기분'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: '일기'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정'),
        ],
      ),
    );
  }
}
