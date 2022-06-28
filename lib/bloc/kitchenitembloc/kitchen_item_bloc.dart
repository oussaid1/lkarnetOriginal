import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lkarnet/models/kitchen/kitchen_item.dart';
import 'package:lkarnet/repository/database_operations.dart';

part 'kitchen_item_event.dart';
part 'kitchen_item_state.dart';

class KitchenItemBloc extends Bloc<KitchenItemEvent, KitchenItemState> {
  late final DatabaseOperations _databaseOperations;
  StreamSubscription? _kitchenItemsSubscription;
  KitchenItemBloc(DatabaseOperations databaseOperations)
      : super(KitchenItemInitial()) {
    _databaseOperations = databaseOperations;
    on<GetKitchenItems>(_getKitchenItems);
    on<LoadKitchenItems>(_loadKitchenItems);
  }

  /// on Get kitchen items from the database.
  _getKitchenItems(
      GetKitchenItems event, Emitter<KitchenItemState> emit) async {
    _kitchenItemsSubscription?.cancel();
    _kitchenItemsSubscription =
        _databaseOperations.kitchenItemsStream().listen((kitchenItems) {
      add(LoadKitchenItems(kitchenItems));
    });
  }

  /// on Load kitchen items from the database.
  _loadKitchenItems(
      LoadKitchenItems event, Emitter<KitchenItemState> emit) async {
    emit(KitchenItemLoaded(event.kitchenItems));
  }
}
