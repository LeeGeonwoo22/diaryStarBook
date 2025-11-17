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
    // ⚙️ 앱 설정 초기화
    final appSettings = AppSettings();
    await appSettings.init();
    Injector.registerLazySingleton<AppSettings>(() => appSettings);

    // 🔥 Firebase
    final firebaseService = FirebaseService();
    await firebaseService.initialise();
    Injector.registerLazySingleton<FirebaseService>(() => firebaseService);

    // 🧾 Reporting
    final reportingService = ReportingService();
    await reportingService.initialise();
    Injector.registerLazySingleton<ReportingService>(() => reportingService);

    // 📊 Analytics
    final analyticsService = AnalyticsService();
    await analyticsService.initialise();
    Injector.registerLazySingleton<AnalyticsService>(() => analyticsService);

    // 🌙 Mood Repository (기본 Hive)
    final moodRepository = MoodRepository();
    await moodRepository.init();
    Injector.registerLazySingleton<MoodRepository>(() => moodRepository);

    // 📔 Journal Repository (Firebase + Hive)
    final journalRepository = JournalRepository(firebaseService: firebaseService);
    await journalRepository.init(); // ✅ 반드시 init() 호출
    Injector.registerLazySingleton<JournalRepository>(() => journalRepository);

    print('[Injector] ✅ All services initialized successfully.');
  }

  static T resolve<T extends Object>() => Injector<T>();
}
