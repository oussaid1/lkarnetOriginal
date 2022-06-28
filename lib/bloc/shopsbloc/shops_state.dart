part of 'shops_bloc.dart';

abstract class ShopsState extends Equatable {
  const ShopsState();

  @override
  List<Object> get props => [];
}

class ShopsInitial extends ShopsState {}

/// shops loaded state
class ShopsLoaded extends ShopsState {
  final List<ShopModel> shops;

  ShopsLoaded(this.shops);

  @override
  List<Object> get props => [shops];
}

/// shops loading state
class ShopsLoading extends ShopsState {}

/// shops error state
class ShopsError extends ShopsState {
  final String message;

  ShopsError(this.message);

  @override
  List<Object> get props => [message];
}
