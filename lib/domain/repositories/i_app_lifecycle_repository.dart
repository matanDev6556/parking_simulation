abstract class IAppLifecycleRepository {
  Future<void> startMonitoring(String userId);
  Future<void> stopMonitoring(String userId);
  Future<void> markOffline(String userId);
}