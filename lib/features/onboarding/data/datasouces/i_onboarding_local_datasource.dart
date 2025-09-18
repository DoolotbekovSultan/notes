abstract class IOnboardingLocalDatasource {
  Future<bool> hasSeenOnboarding();
  Future<void> wasSeenOnboarding();
}
