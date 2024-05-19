import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../repositories/financial_repo.dart';
import '../finance_provider.dart';

part 'home_provider.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const HomeState._();
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loadInProgress() = _LoadInProgress;
  const factory HomeState.loadSuccess() = _LoadSuccess;
  const factory HomeState.loadFailure() = _LoadFailure;
}

class HomeStateNotifier extends StateNotifier<HomeState> {
  HomeStateNotifier(this.repository) : super(const HomeState.initial());

  final FinanceRepository repository;

  void loadHomeData() async {
    try {
      state = const HomeState.loadInProgress();
      // Simulate a network call or data fetching
      await Future.delayed(const Duration(seconds: 2));
      state = const HomeState.loadSuccess();
    } catch (e) {
      state = const HomeState.loadFailure();
    }
  }
}

final homeStateNotifierProvider =
    StateNotifierProvider<HomeStateNotifier, HomeState>((ref) {
  final repository = ref.watch(financeRepositoryProvider);
  return HomeStateNotifier(repository);
});
