import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/utils/routes/app_routes.dart';
import 'package:spendwise/views/splash/splash_screen.dart';

import '../../views/home/home_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.home,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.splash,
          builder: (BuildContext context, GoRouterState state) {
            return const SplashScreen();
          },
        ),
      ],
    ),
  ],
);
