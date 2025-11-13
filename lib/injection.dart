import 'package:get_it/get_it.dart';

import 'core/app_settings.dart';
import 'domain/repository/journal_repository.dart';
import 'domain/repository/mood_repository.dart';
import 'core/analytics_service.dart';
import 'core/reporting_service.dart';
import 'core/firebase_service.dart';

final Injector = GetIt.instance;

class InjectorSetup {
  static Future<void> initialise() async {
    // 앱설정
    final appSettings = AppSettings();
    await appSettings.init();
    Injector.registerLazySingleton(() => AppSettings());
    // core service
    Injector.registerLazySingleton(() => FirebaseService());
    Injector.registerLazySingleton(() => ReportingService());
    Injector.registerLazySingleton(() => AnalyticsService());
    // domain repositories
    Injector.registerLazySingleton(() => MoodRepository());
    Injector.registerLazySingleton(() => JournalRepository());

    print('[Injector] ✅ All services initialized successfully.');
  }
  static T resolve<T extends Object>() => Injector<T>();
}
