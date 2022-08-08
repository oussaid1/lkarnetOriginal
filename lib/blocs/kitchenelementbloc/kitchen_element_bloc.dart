import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lkarnet/models/kitchen/kitchen_element.dart';
import 'package:lkarnet/repository/database_operations.dart';

part 'kitchen_element_event.dart';
part 'kitchen_element_state.dart';

class KitchenElementBloc
    extends Bloc<KitchenElementEvent, KitchenElementState> {
  late final DatabaseOperations databaseOperations;
  StreamSubscription? _kitchenElementSubscription;
  KitchenElementBloc(DatabaseOperations databaseOperations)
      : super(KitchenElementState(
          status: KitchenElementStatus.initial,
          kitchenElements: [],
          error: '',
        )) {
    this.databaseOperations = databaseOperations;
    on<GetAllKitchenElements>(_onGetAllKitchenElements);
    on<LoadKitchenElements>(_onLoadKitchenElements);
    on<AddKitchenElement>(_onAddKitchenElement);
    on<UpdateKitchenElement>(_onUpdateKitchenElement);
    on<DeleteKitchenElement>(_onDeleteKitchenElement);
  }
  void _onGetAllKitchenElements(
      GetAllKitchenElements event, Emitter<KitchenElementState> emit) async {
    _kitchenElementSubscription = databaseOperations
        .kitchenElementsStream()
        .listen((kitchenElements) => emit(state.copyWith(
            status: KitchenElementStatus.loaded,
            kitchenElements: kitchenElements)));
  }

  void _onLoadKitchenElements(
      LoadKitchenElements event, Emitter<KitchenElementState> emit) async {
    emit(state.copyWith(
        status: KitchenElementStatus.loading,
        kitchenElements: event.kitchenElements));
  }

  void _onAddKitchenElement(
      AddKitchenElement event, Emitter<KitchenElementState> emit) async {
    try {
      await databaseOperations.addKitchenElement(event.kitchenElement);
      emit(state.copyWith(status: KitchenElementStatus.added));
    } catch (error) {
      emit(state.copyWith(status: KitchenElementStatus.error, error: '$error'));
    }
  }

  void _onUpdateKitchenElement(
      UpdateKitchenElement event, Emitter<KitchenElementState> emit) async {
    try {
      await databaseOperations.updateKitchenElement(event.kitchenElement);
      emit(state.copyWith(status: KitchenElementStatus.updated));
    } catch (error) {
      emit(state.copyWith(status: KitchenElementStatus.error, error: '$error'));
    }
  }

  void _onDeleteKitchenElement(
      DeleteKitchenElement event, Emitter<KitchenElementState> emit) async {
    try {
      await databaseOperations.deleteKitchenElement(event.kitchenElement);
      emit(state.copyWith(status: KitchenElementStatus.deleted));
    } catch (error) {
      emit(state.copyWith(status: KitchenElementStatus.error, error: '$error'));
    }
  }

  @override
  Future<void> close() {
    _kitchenElementSubscription?.cancel();
    return super.close();
  }
}
