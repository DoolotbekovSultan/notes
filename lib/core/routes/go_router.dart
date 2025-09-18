import 'package:go_router/go_router.dart';
import 'package:note/core/presentation/splash_screen.dart';
import 'package:note/core/routes/route_names.dart';
import 'package:note/features/notes/presentation/screens/notes_screen.dart';
import 'package:note/features/onboarding/presentation/screens/onboarding_screen.dart';

final goRouter = GoRouter(
  initialLocation: RouteNames.splash,
  routes: <RouteBase>[
    GoRoute(
      path: RouteNames.splash,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: RouteNames.onboarding,
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(path: RouteNames.notes, builder: (context, state) => NotesScreen()),
  ],
);
