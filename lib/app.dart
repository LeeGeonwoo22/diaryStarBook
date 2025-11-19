import 'package:flutter/material.dart';
import 'package:star_book_refactory/presentation/routes/app_router.dart';
import 'package:star_book_refactory/presentation/theme/ultramarine_light.dart';

class StarBookApp extends StatelessWidget {

  const StarBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'StarBook',
      debugShowCheckedModeBanner: false,
      theme: UltramarineLightTheme().theme,
      routerConfig: AppRouter.router,
    );
  }
}
