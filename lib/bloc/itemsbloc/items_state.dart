part of 'items_bloc.dart';

abstract class ItemsState extends Equatable {
  const ItemsState();

  @override
  List<Object> get props => [];
}

/// Initial state
class ItemsInitial extends ItemsState {}

/// Loading state
class ItemsLoadingState extends ItemsState {}

/// items loaded from database
class ItemsLoadedState extends ItemsState {
  final List<ItemModel> items;

  ItemsLoadedState(this.items);

  @override
  List<Object> get props => [items];
}
