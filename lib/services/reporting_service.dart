// lib/services/reporting_service.dart
// 앱의 오류, 이벤트 로그, 성능 관련 리포트를 담당
// 현재는 Firebase Crashlytics 없이 콘솔 출력 형태로 대체


class ReportingService {
  Future<void> initialise() async{
    print('[ReportingService] Initialized.');
  }

  void log(String message) {
    print('[ReportingService] $message');
  }

  void reportError(Object error, StackTrace stackTrace) {
    print('[ReportingService] ERROR: $error');
  }
}