import 'package:get_it/get_it.dart';

import '../../app_settings.dart';
import '../../domain/repository/mood_repository.dart';
import '../../services/analytics_service.dart';
import '../../services/firebase_service.dart';
import '../../services/reporting_service.dart';

final Injector = GetIt.instance;

class InjectorSetup {
  static Future<void> initialise() async {
    final appSettings = AppSettings();
    await appSettings.init();
    Injector.registerLazySingleton(() => AppSettings());
    Injector.registerLazySingleton(() => FirebaseService());
    Injector.registerLazySingleton(() => ReportingService());
    Injector.registerLazySingleton(() => AnalyticsService());
    Injector.registerLazySingleton(() => MoodRepository());

    print('[Injector] Services registered.');
  }
  static T resolve<T extends Object>() => Injector<T>();
}
