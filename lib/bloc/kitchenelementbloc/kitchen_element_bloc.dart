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
      : super(KitchenElementInitial()) {
    this.databaseOperations = databaseOperations;

    on<GetAllKitchenElements>(_getAllKitchenElements);
    on<LoadKitchenElements>(_loadKitchenElements);
  }

  /// Get all kitchen elements.
  void _getAllKitchenElements(
      GetAllKitchenElements event, Emitter<KitchenElementState> emit) {
    _kitchenElementSubscription?.cancel();
    _kitchenElementSubscription =
        databaseOperations.kitchenElementsStream().listen((kitchenElements) {
      add(LoadKitchenElements(kitchenElements));
    });
  }

  /// Load kitchen elements.
  void _loadKitchenElements(
      LoadKitchenElements event, Emitter<KitchenElementState> emit) {
    emit(KitchenElementLoaded(event.kitchenElements));
  }

  @override
  Future<void> close() {
    _kitchenElementSubscription?.cancel();
    return super.close();
  }
}
