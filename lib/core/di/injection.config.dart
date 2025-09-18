// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:note/core/di/injection_module.dart' as _i1047;
import 'package:note/features/onboarding/data/datasouces/i_onboarding_local_datasource.dart'
    as _i762;
import 'package:note/features/onboarding/data/datasouces/onboarding_local_datasource.dart'
    as _i269;
import 'package:note/features/onboarding/data/repositories/onboarding_repository.dart'
    as _i518;
import 'package:note/features/onboarding/domain/repositories/i_onboarding_repository.dart'
    as _i213;
import 'package:note/features/onboarding/domain/usecases/has_seen_onboarding_usecase.dart'
    as _i512;
import 'package:note/features/onboarding/domain/usecases/was_seen_onboarding_usecase.dart'
    as _i926;
import 'package:note/features/onboarding/presentation/cubit/onboarding_cubit.dart'
    as _i408;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i762.IOnboardingLocalDatasource>(
      () => _i269.OnboardingLocalDatasource(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i213.IOnboardingRepository>(
      () => _i518.OnboardingRepository(gh<_i762.IOnboardingLocalDatasource>()),
    );
    gh.lazySingleton<_i512.HasSeenOnboardingUsecase>(
      () => _i512.HasSeenOnboardingUsecase(gh<_i213.IOnboardingRepository>()),
    );
    gh.lazySingleton<_i926.WasSeenOnboardingUsecase>(
      () => _i926.WasSeenOnboardingUsecase(gh<_i213.IOnboardingRepository>()),
    );
    gh.lazySingleton<_i408.OnboardingCubit>(
      () => _i408.OnboardingCubit(
        gh<_i512.HasSeenOnboardingUsecase>(),
        gh<_i926.WasSeenOnboardingUsecase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i1047.RegisterModule {}
