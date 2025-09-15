import 'package:injectable/injectable.dart';
import 'package:note/features/onboard/data/datasouces/i_onboard_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: IOnboardLocalDatasource)
class OnboardLocalDatasource implements IOnboardLocalDatasource {
  final SharedPreferences _sharedPreferences;
  const OnboardLocalDatasource(this._sharedPreferences);

  static const _key = "hasSeenOnBoard";

  @override
  Future<bool> hasSeenOnboard() async =>
      _sharedPreferences.getBool(_key) ?? false;

  @override
  Future<void> wasSeenOnboard() async => _sharedPreferences.setBool(_key, true);
}
