part of 'kit_bloc.dart';

@immutable
sealed class KitState {}

final class KitInitial extends KitState {}
final class KitLoadingState extends KitState {}

final class KitLoaded extends KitState {
  final List <Kit> kits;

  KitLoaded({required this.kits});
}

final class KitErrorState extends KitState {
  final String errorMessage;

  KitErrorState({required this.errorMessage});
}
