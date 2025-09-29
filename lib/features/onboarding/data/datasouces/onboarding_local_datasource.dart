import 'package:injectable/injectable.dart';
import 'package:note/features/onboarding/data/datasouces/i_onboarding_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _hasSeenOnboarding = "HAS_SEEN_ONBOARDING";

@LazySingleton(as: IOnboardingLocalDatasource)
class OnboardingLocalDatasource implements IOnboardingLocalDatasource {
  final SharedPreferences _sharedPreferences;
  const OnboardingLocalDatasource(this._sharedPreferences);

  @override
  Future<bool> hasSeenOnboarding() async =>
      _sharedPreferences.getBool(_hasSeenOnboarding) ?? false;

  @override
  Future<void> wasSeenOnboarding() async =>
      _sharedPreferences.setBool(_hasSeenOnboarding, true);
}
