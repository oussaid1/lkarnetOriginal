part of 'kitchen_element_bloc.dart';

abstract class KitchenElementState extends Equatable {
  const KitchenElementState();

  @override
  List<Object> get props => [];
}

/// Initial state of the bloc.
class KitchenElementInitial extends KitchenElementState {}

/// State when the kitchen elements are loading.
class KitchenElementLoading extends KitchenElementState {}

/// State when the kitchen elements are loaded.
class KitchenElementLoaded extends KitchenElementState {
  final List<KitchenElementModel> kitchenElements;

  KitchenElementLoaded(this.kitchenElements);

  @override
  List<Object> get props => [kitchenElements];
}
