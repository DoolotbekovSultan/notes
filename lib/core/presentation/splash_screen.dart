import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note/core/di/injection.dart';
import 'package:note/core/routes/route_names.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/onboarding/presentation/cubit/onboarding_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    logger.d("[SplashScreen] start");
    super.initState();
    _init();
  }

  @override
  void dispose() {
    logger.d("[SplashScreen] finish");
    super.dispose();
  }

  void _init() async {
    final onboardingCubit = getIt<OnboardingCubit>();
    await onboardingCubit.loadHasSeenBoard();

    if (!mounted) return;

    if (onboardingCubit.state is OnboardingShow) {
      logger.d("[SplashScreen] onboarding show");
      logger.d("[SplashScreen] navigate to onboarding screen");
      context.go(RouteNames.onboarding);
    } else {
      logger.d("[SplashScreen] onboarding skip");
      logger.d("[SplashScreen] navigate to notes screen");
      context.go(RouteNames.notes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
