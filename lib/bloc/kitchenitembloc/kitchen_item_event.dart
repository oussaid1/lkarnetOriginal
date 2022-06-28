part of 'kitchen_item_bloc.dart';

abstract class KitchenItemEvent extends Equatable {
  const KitchenItemEvent();

  @override
  List<Object> get props => [];
}

/// get kitchen items event
class GetKitchenItems extends KitchenItemEvent {}

/// load kitchen items event
class LoadKitchenItems extends KitchenItemEvent {
  final List<KitchenItemModel> kitchenItems;
  LoadKitchenItems(this.kitchenItems);
  @override
  List<Object> get props => [kitchenItems];
}
