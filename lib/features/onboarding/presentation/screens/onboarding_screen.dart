import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:note/core/di/injection.dart';
import 'package:note/core/routes/route_names.dart';
import 'package:note/core/theme/app_colors.dart';
import 'package:note/core/theme/app_dimens.dart';
import 'package:note/core/theme/app_spacing.dart';
import 'package:note/core/theme/app_text_styles.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/onboarding/data/onboarding_items.dart';
import 'package:note/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:note/features/onboarding/presentation/widgets/onboarding_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatefulWidget {
  final cubit = getIt<OnboardingCubit>()..changePage(0);

  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    logger.d('[OnboardingScreen] start');
    super.initState();
  }

  @override
  void dispose() {
    logger.d('[OnboardingScreen] finish');
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<OnboardingCubit, OnboardingState>(
              bloc: widget.cubit,
              listener: (context, state) {
                switch (state) {
                  case OnboardingError(:final failure):
                    logger.e("[OnboardingScreen] Ошибка: ${failure.message}");
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(failure.message)));
                    break;
                  case OnboardingSkip():
                  case OnboardingNextButtonClicked():
                    widget.cubit.saveWasSeenBoard();
                    logger.d("[OnboardingScreen] переходим в notes screen");
                    context.go(RouteNames.notes);
                    break;
                  case OnboardingSkipTextClicked():
                    logger.d(
                      "[OnboardingScreen] пропускаем все onboarding pages",
                    );
                    _pageController.jumpToPage(onboardingItems.length - 1);
                  default:
                }
              },
            ),
          ],
          child: BlocBuilder<OnboardingCubit, OnboardingState>(
            bloc: widget.cubit,
            builder: (context, state) {
              switch (state) {
                case OnboardingChangePage(
                  page: final currentPage,
                  :final skipTextVisibility,
                  :final startButtonVisibility,
                ):
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.all(AppDimens.paddingMd.r),
                          child: Visibility(
                            visible: skipTextVisibility,
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            child: GestureDetector(
                              onTap: () {
                                logger.d(
                                  "[OnboardingScreen] skip text был нажат",
                                );
                                widget.cubit.skipTextClicked();
                              },
                              child: Text(
                                "Пропустить",
                                style: AppTextStyles.poppins15SemiBold.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Notes",
                          style: AppTextStyles.pottaOne24Regular,
                        ),
                      ),
                      AppSpacing.h32,
                      SizedBox(
                        height: 490.h,
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (page) {
                            if (page != currentPage) {
                              widget.cubit.changePage(page);
                            }
                          },
                          itemCount: onboardingItems.length,
                          itemBuilder: (context, index) =>
                              OnboardingPage(entity: onboardingItems[index]),
                        ),
                      ),
                      AppSpacing.h24,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          onboardingItems.length,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppDimens.paddingXss.w,
                            ),
                            child: Container(
                              width: 12.w,
                              height: 11.h,
                              decoration: BoxDecoration(
                                color: currentPage == index
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Visibility(
                            visible: startButtonVisibility,
                            child: ElevatedButton(
                              onPressed: () {
                                logger.d(
                                  "[OnboardingScreen] start button был нажат",
                                );
                                widget.cubit.nextButtonClicked();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppDimens.radiusM,
                                  ),
                                ),
                                fixedSize: Size(230.w, 58.h),
                              ),
                              child: Text(
                                "Начать",
                                style: AppTextStyles.roboto21Bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
