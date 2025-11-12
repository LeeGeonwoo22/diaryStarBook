import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:star_book_refactory/presentation/Injector/injection.dart';
import 'package:star_book_refactory/services/analytics_service.dart';
import 'package:star_book_refactory/services/firebase_service.dart';
import 'package:star_book_refactory/services/reporting_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  // hive 초기화
  await Hive.initFlutter(dir.path);
  await Hive.openBox('moodBox');
  // 의존성 초기화
  await InjectorSetup.initialise();
  // firebase 서비스 수동 초기화
  await InjectorSetup.resolve<FirebaseService>().initialise();
  await InjectorSetup.resolve<ReportingService>().initialise();
  await InjectorSetup.resolve<AnalyticsService>().initialise();


  runApp(const StarBookApp());
}




