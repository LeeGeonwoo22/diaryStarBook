import 'package:flutter/material.dart';
import 'package:star_book_refactory/presentation/routes/app_router.dart';

class StarBookApp extends StatelessWidget {
  const StarBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'StarBook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      routerConfig: AppRouter.router,
    );
  }
}
