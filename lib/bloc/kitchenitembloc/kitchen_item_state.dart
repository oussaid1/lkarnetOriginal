part of 'kitchen_item_bloc.dart';

abstract class KitchenItemState extends Equatable {
  const KitchenItemState();

  @override
  List<Object> get props => [];
}

/// Initial state of the bloc.
class KitchenItemInitial extends KitchenItemState {}

/// State when the bloc is loading.
class KitchenItemLoading extends KitchenItemState {}

/// State when the bloc is loaded.
class KitchenItemLoaded extends KitchenItemState {
  final List<KitchenItemModel> kitchenItems;
  KitchenItemLoaded(this.kitchenItems);
  @override
  List<Object> get props => [kitchenItems];
}
