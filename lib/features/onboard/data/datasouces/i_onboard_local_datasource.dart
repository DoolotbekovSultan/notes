abstract class IOnboardLocalDatasource {
  Future<bool> hasSeenOnboard();
  Future<void> wasSeenOnboard();
}
