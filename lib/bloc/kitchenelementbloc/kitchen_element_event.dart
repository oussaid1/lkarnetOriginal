part of 'kitchen_element_bloc.dart';

abstract class KitchenElementEvent extends Equatable {
  const KitchenElementEvent();

  @override
  List<Object> get props => [];
}

/// Event to get all kitchen elements.
class GetAllKitchenElements extends KitchenElementEvent {}

/// kitchen elements loaded .
class LoadKitchenElements extends KitchenElementEvent {
  final List<KitchenElementModel> kitchenElements;

  LoadKitchenElements(this.kitchenElements);

  @override
  List<Object> get props => [kitchenElements];
}
