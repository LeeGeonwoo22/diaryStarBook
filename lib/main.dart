import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:star_book_refactory/injection.dart';
import 'package:star_book_refactory/core/analytics_service.dart';
import 'package:star_book_refactory/core/reporting_service.dart';
import 'package:star_book_refactory/presentation/theme/ultramarine_light.dart';
import 'app.dart';
import 'core/firebase_service.dart';
import 'domain/repository/journal_repository.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  // hive 초기화
  await Hive.initFlutter(dir.path);
  await Hive.openBox('moodBox');
  // 의존성 초기화
  await InjectorSetup.initialise();
  // journalRepository
  await InjectorSetup.resolve<JournalRepository>().init();
  //  화면 방향 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // 상태바 스타일 설정
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );


  runApp(const StarBookApp());
}




