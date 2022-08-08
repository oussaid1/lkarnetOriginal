part of 'kitchen_element_bloc.dart';

abstract class KitchenElementEvent extends Equatable {
  const KitchenElementEvent();

  @override
  List<Object> get props => [];
}

class GetAllKitchenElements extends KitchenElementEvent {}

class LoadKitchenElements extends KitchenElementEvent {
  final List<KitchenElementModel> kitchenElements;
  LoadKitchenElements({required this.kitchenElements});
  @override
  List<Object> get props => [kitchenElements];
}

class AddKitchenElement extends KitchenElementEvent {
  final KitchenElementModel kitchenElement;
  AddKitchenElement({required this.kitchenElement});
  @override
  List<Object> get props => [kitchenElement];
}

class UpdateKitchenElement extends KitchenElementEvent {
  final KitchenElementModel kitchenElement;
  UpdateKitchenElement({required this.kitchenElement});
  @override
  List<Object> get props => [kitchenElement];
}

class DeleteKitchenElement extends KitchenElementEvent {
  final KitchenElementModel kitchenElement;
  DeleteKitchenElement({required this.kitchenElement});
  @override
  List<Object> get props => [kitchenElement];
}
