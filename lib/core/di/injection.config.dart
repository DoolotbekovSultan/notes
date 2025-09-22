// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/notes/data/datasources/i_note_local_datasource.dart'
    as _i787;
import '../../features/notes/data/datasources/note_local_datasource.dart'
    as _i707;
import '../../features/notes/data/repositories/note_repository.dart' as _i270;
import '../../features/notes/domain/repositories/i_note_repository.dart'
    as _i357;
import '../../features/notes/domain/usecases/get_all_notes_usecase.dart'
    as _i370;
import '../../features/notes/domain/usecases/insert_note_usecase.dart' as _i138;
import '../../features/notes/presentation/bloc/notes_bloc.dart' as _i207;
import '../../features/onboarding/data/datasouces/i_onboarding_local_datasource.dart'
    as _i833;
import '../../features/onboarding/data/datasouces/onboarding_local_datasource.dart'
    as _i130;
import '../../features/onboarding/data/repositories/onboarding_repository.dart'
    as _i284;
import '../../features/onboarding/domain/repositories/i_onboarding_repository.dart'
    as _i442;
import '../../features/onboarding/domain/usecases/has_seen_onboarding_usecase.dart'
    as _i690;
import '../../features/onboarding/domain/usecases/was_seen_onboarding_usecase.dart'
    as _i707;
import '../../features/onboarding/presentation/cubit/onboarding_cubit.dart'
    as _i807;
import '../db/app_database.dart' as _i951;
import 'injection_module.dart' as _i212;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    await gh.factoryAsync<_i951.AppDatabase>(
      () => registerModule.database,
      preResolve: true,
    );
    gh.lazySingleton<_i833.IOnboardingLocalDatasource>(
        () => _i130.OnboardingLocalDatasource(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i442.IOnboardingRepository>(() =>
        _i284.OnboardingRepository(gh<_i833.IOnboardingLocalDatasource>()));
    gh.lazySingleton<_i690.HasSeenOnboardingUsecase>(() =>
        _i690.HasSeenOnboardingUsecase(gh<_i442.IOnboardingRepository>()));
    gh.lazySingleton<_i707.WasSeenOnboardingUsecase>(() =>
        _i707.WasSeenOnboardingUsecase(gh<_i442.IOnboardingRepository>()));
    gh.lazySingleton<_i787.INoteLocalDatasource>(
        () => _i707.NoteLocalDatasource(gh<_i951.AppDatabase>()));
    gh.lazySingleton<_i807.OnboardingCubit>(() => _i807.OnboardingCubit(
          gh<_i690.HasSeenOnboardingUsecase>(),
          gh<_i707.WasSeenOnboardingUsecase>(),
        ));
    gh.lazySingleton<_i357.INoteRepository>(
        () => _i270.NoteRepository(gh<_i787.INoteLocalDatasource>()));
    gh.lazySingleton<_i138.InsertNoteUsecase>(
        () => _i138.InsertNoteUsecase(gh<_i357.INoteRepository>()));
    gh.lazySingleton<_i370.GetAllNotesUsecase>(
        () => _i370.GetAllNotesUsecase(gh<_i357.INoteRepository>()));
    gh.lazySingleton<_i207.NotesBloc>(() => _i207.NotesBloc(
          gh<_i370.GetAllNotesUsecase>(),
          gh<_i138.InsertNoteUsecase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i212.RegisterModule {}
