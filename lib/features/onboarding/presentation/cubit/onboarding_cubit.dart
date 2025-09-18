import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/onboarding/data/onboarding_items.dart';
import 'package:note/features/onboarding/domain/failure/onboarding_failure.dart';
import 'package:note/features/onboarding/domain/usecases/has_seen_onboarding_usecase.dart';
import 'package:note/features/onboarding/domain/usecases/was_seen_onboarding_usecase.dart';

part 'onboarding_state.dart';

@lazySingleton
class OnboardingCubit extends Cubit<OnboardingState> {
  final HasSeenOnboardingUsecase _hasSeenOnboardingUsecase;
  final WasSeenOnboardingUsecase _wasSeenOnboardingUsecase;

  OnboardingCubit(
    this._hasSeenOnboardingUsecase,
    this._wasSeenOnboardingUsecase,
  ) : super(OnboardingInitial());

  Future<void> loadHasSeenBoard() async {
    logger.d('loadHasSeenBoard вызван');
    final result = await _hasSeenOnboardingUsecase();

    result.fold(
      (failure) {
        logger.e('Ошибка загрузки Onboarding', error: failure);
        emit(OnboardingError(failure));
      },
      (hasSeenOnboard) {
        emit(hasSeenOnboard ? OnboardingSkip() : OnboardingShow());
        logger.i("Состояние изменено на ${state.runtimeType}");
      },
    );
  }

  Future<void> saveWasSeenBoard() async {
    logger.d('wasSeenBoard вызван');
    final result = await _wasSeenOnboardingUsecase();

    result.fold(
      (failure) {
        logger.e('Ошибка записи Onboarding', error: failure);
        emit(OnboardingError(failure));
      },
      (_) {
        logger.i("Onboarding помечен как просмотренный");
      },
    );
  }

  Future<void> nextButtonClicked() async {
    logger.d('nextButtonClicked вызван');
    emit(OnboardingNextButtonClicked());
  }

  Future<void> skipTextClicked() async {
    logger.d('skipTextClicked вызван');
    emit(OnboardingSkipTextClicked());
    changePage(onboardingItems.length - 1);
  }

  Future<void> changePage(int page) async {
    logger.d('changePage($page) вызван');
    final isLastPage = page == onboardingItems.length - 1;
    final skipTextVisibility = !isLastPage;
    final startButtonVisibility = isLastPage;
    emit(
      OnboardingChangePage(
        page: page,
        skipTextVisibility: skipTextVisibility,
        startButtonVisibility: startButtonVisibility,
      ),
    );
  }
}
