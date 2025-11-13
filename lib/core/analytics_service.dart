// lib/services/analytics_service.dart
// Firebase Analytics 기반 사용자 이벤트 추적
// 현재는 실제 FirebaseAnalytics 대신 콘솔 기반 Mock으로 구현

class AnalyticsService {
  Future<void> initialise() async {
    print('[AnalyticsService] Initialized.');
  }

  /// ✅ 사용자 행동 로깅
  void logEvent(String eventName, {Map<String, dynamic>? params}) {
    print('[AnalyticsService] EVENT: $eventName | PARAMS: $params');
  }
}
