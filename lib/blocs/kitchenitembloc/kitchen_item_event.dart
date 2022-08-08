part of 'kitchen_item_bloc.dart';

abstract class KitchenItemEvent extends Equatable {
  const KitchenItemEvent();

  @override
  List<Object> get props => [];
}

/// get kitchen items event
class GetKitchenItems extends KitchenItemEvent {}

/// load kitchen items event
class LoadKitchenItemsEvent extends KitchenItemEvent {
  final List<KitchenItemModel> kitchenItems;
  LoadKitchenItemsEvent(this.kitchenItems);
  @override
  List<Object> get props => [kitchenItems];
}

/// add kitchen item event
class AddKitchenItemEvent extends KitchenItemEvent {
  final KitchenItemModel kitchenItem;
  AddKitchenItemEvent(this.kitchenItem);
  @override
  List<Object> get props => [kitchenItem];
}

/// update kitchen item event
class UpdateKitchenItemEvent extends KitchenItemEvent {
  final KitchenItemModel kitchenItem;
  UpdateKitchenItemEvent(this.kitchenItem);
  @override
  List<Object> get props => [kitchenItem];
}

/// delete kitchen item event
class DeleteKitchenItemEvent extends KitchenItemEvent {
  final KitchenItemModel kitchenItem;
  DeleteKitchenItemEvent(this.kitchenItem);
  @override
  List<Object> get props => [kitchenItem];
}
