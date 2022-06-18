import 'package:lkarnet/components.dart';
import 'package:lkarnet/repository/database_operations.dart';
import 'dart:async';
import '../../models/item/item.dart';
part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  /// stream subscription to get the items from the database
  late final DatabaseOperations _databaseOperations;
  late final StreamSubscription<List<ItemModel>> _itemsSubscription;
  ItemsBloc({required DatabaseOperations databaseOperations})
      : super(ItemsInitial()) {
    this._databaseOperations = databaseOperations;
    _itemsSubscription = _databaseOperations.itemStream().listen((items) {
      // log('items loaded from database ${items.length}');
      add(LoadItemsEvent(items));
    });
    on<LoadItemsEvent>((event, emit) {
      emit(ItemsLoadedState(event.items));
    });
  }

  /// onloaditems event
  void _onLoadItems(LoadItemsEvent event, Emitter<ItemsState> emit) async {
    emit(ItemsLoadedState(event.items));
  }

  /// on get items event
  Future<void> _onGetItems(Emitter<ItemsState> emit) async {
    emit(ItemsLoadingState());
    // _itemsSubscription.cancel();
    _itemsSubscription = _databaseOperations.itemStream().listen((items) {
      log('items loaded from database ${items.length}');
      emit(ItemsLoadedState(items));
    });
  }

  @override
  Future<void> close() {
    _itemsSubscription.cancel();
    return super.close();
  }
}
