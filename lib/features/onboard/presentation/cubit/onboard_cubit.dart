import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/onboard/domain/failure/onboard_failure.dart';
import 'package:note/features/onboard/domain/usecases/has_seen_onboard_usecase.dart';
import 'package:note/features/onboard/domain/usecases/was_seen_onboard_usecase.dart';

part 'onboard_state.dart';

@lazySingleton
class OnboardCubit extends Cubit<OnboardState> {
  final HasSeenOnboardUsecase _hasSeenOnboardUsecase;
  final WasSeenOnboardUsecase _wasSeenOnboardUsecase;

  OnboardCubit(this._hasSeenOnboardUsecase, this._wasSeenOnboardUsecase)
    : super(OnboardInitial());

  Future<void> loadHasSeenBoard() async {
    logger.d('loadHasSeenBoard вызван');
    final result = await _hasSeenOnboardUsecase();

    result.fold(
      (failure) {
        logger.e('Ошибка загрузки Onboard', error: failure);
        emit(OnboardError(failure));
      },
      (hasSeenOnboard) {
        logger.i({"Состояние изменено на ${state.runtimeType}"});
        emit(hasSeenOnboard ? OnboardShow() : OnboardSkip());
      },
    );
  }

  Future<void> saveWasSeenBoard() async {
    logger.d('wasSeenBoard вызван');
    final result = await _wasSeenOnboardUsecase();

    result.fold(
      (failure) {
        logger.e('Ошибка записи Onboard', error: failure);
        emit(OnboardError(failure));
      },
      (_) {
        logger.i("Onboard помечен как просмотренный");
      },
    );
  }
}
