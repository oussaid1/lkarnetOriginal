import 'package:lkarnet/components.dart';
import 'package:lkarnet/repository/database_operations.dart';
import 'dart:async';
import '../../models/item/item.dart';
part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  /// stream subscription to get the items from the database
  late final DatabaseOperations _databaseOperations;
  StreamSubscription<List<ItemModel>>? _itemsSubscription;
  ItemsBloc({required DatabaseOperations databaseOperations})
      : super(ItemsInitial()) {
    this._databaseOperations = databaseOperations;

    on<GetItemsEvent>(_onGetItems);

    on<LoadItemsEvent>(_onLoadItems);

    on<AddItemEvent>((event, emit) {
      _databaseOperations.addItem(event.item);
      add(GetItemsEvent());
    });
  }

  /// onloaditems event
  void _onLoadItems(LoadItemsEvent event, Emitter<ItemsState> emit) async {
    emit(ItemsLoadedState(event.items));
  }

  /// on get items event
  Future<void> _onGetItems(ItemsEvent event, Emitter<ItemsState> emit) async {
    // if (_itemsSubscription != null) {
    // _itemsSubscription!.cancel();
    // }
    _itemsSubscription = _databaseOperations
        .itemStream()
        .listen((items) => add(LoadItemsEvent(items)));
  }

  @override
  Future<void> close() {
    _itemsSubscription!.cancel();
    return super.close();
  }
}
