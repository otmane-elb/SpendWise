import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/core/routes/app_routes.dart';
import 'package:spendwise/views/add_Transaction/add_trasaction.dart';
import 'package:spendwise/views/getstared/get_started_screen.dart';
import 'package:spendwise/views/splash/splash_screen.dart';
import 'package:spendwise/views/transaction_details/transaction_details.dart';

import '../../utils/extentions/get_transaction_by_id.dart';
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
        GoRoute(
          path: AppRoutes.addTransaction,
          name: AppRoutes.addTransaction,
          builder: (BuildContext context, GoRouterState state) {
            return const AddTransaction();
          },
        ),
        GoRoute(
          path: AppRoutes.transactionDetails,
          name: AppRoutes.transactionDetails,
          builder: (BuildContext context, GoRouterState state) {
            final transactionId = state.pathParameters['id']!;
            final transaction = getTransactionById(transactionId);
            if (transaction != null) {
              return TransactionDetails(transaction: transaction);
            } else {
              return const Scaffold(
                body: Center(child: Text('Transaction not found')),
              );
            }
          },
        ),

      ],
    ),
  ],
);
