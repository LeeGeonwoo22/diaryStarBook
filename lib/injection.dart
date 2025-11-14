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
    Injector.registerLazySingleton<AppSettings>(() => appSettings);
    // core service
    final reportingService = ReportingService();
    await reportingService.initialise();
    Injector.registerLazySingleton<ReportingService>(() => reportingService);

    final firebaseService = FirebaseService();
    await firebaseService.initialise();
    Injector.registerLazySingleton<FirebaseService>(() => firebaseService);

    final analyticsService = AnalyticsService();
    await analyticsService.initialise();
    Injector.registerLazySingleton<AnalyticsService>(() => analyticsService);
    // domain repositories
    Injector.registerLazySingleton(() => MoodRepository());
    Injector.registerLazySingleton(() => JournalRepository());

    print('[Injector] ✅ All services initialized successfully.');
  }
  static T resolve<T extends Object>() => Injector<T>();
}
