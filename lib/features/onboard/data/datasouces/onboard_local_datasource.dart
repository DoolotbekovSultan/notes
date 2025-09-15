import 'package:injectable/injectable.dart';
import 'package:note/features/onboard/data/datasouces/i_onboard_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: IOnboardLocalDatasource)
class OnboardLocalDatasource implements IOnboardLocalDatasource {
  final SharedPreferences sharedPreferences;
  const OnboardLocalDatasource(this.sharedPreferences);

  static const _key = "hasSeenOnBoard";

  @override
  Future<bool> hasSeenOnboard() async =>
      sharedPreferences.getBool(_key) ?? false;

  @override
  Future<void> wasSeenOnboard() async => sharedPreferences.setBool(_key, true);
}
