import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StarBook Home')),
      body:  Center(
        child: ElevatedButton(
          onPressed: () {
            // ✅ GoRouter 전용 이동 방식
            context.go('/mood');
          },
          child: const Text('무드 트래커로 이동 🌙'),
        ),
      ),
    );
  }
}
