import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/utils/routes/app_routes.dart';
import 'package:spendwise/views/getstared/get_started_screen.dart';
import 'package:spendwise/views/splash/splash_screen.dart';

import '../../views/home/home_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.splash,
      name: AppRoutes.splash,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.home,
          name: AppRoutes.home,
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
        ),
        GoRoute(
          path: AppRoutes.getStarted,
          name: AppRoutes.getStarted,
          builder: (BuildContext context, GoRouterState state) {
            return const GetStartedScreen();
          },
        ),
      ],
    ),
  ],
);
