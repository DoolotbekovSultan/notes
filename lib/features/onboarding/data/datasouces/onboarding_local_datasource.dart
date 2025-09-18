import 'package:injectable/injectable.dart';
import 'package:note/features/onboarding/data/datasouces/i_onboarding_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: IOnboardingLocalDatasource)
class OnboardingLocalDatasource implements IOnboardingLocalDatasource {
  final SharedPreferences _sharedPreferences;
  const OnboardingLocalDatasource(this._sharedPreferences);

  static const _key = "hasSeenOnBoarding";

  @override
  Future<bool> hasSeenOnboarding() async =>
      _sharedPreferences.getBool(_key) ?? false;

  @override
  Future<void> wasSeenOnboarding() async =>
      _sharedPreferences.setBool(_key, true);
}
