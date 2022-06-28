import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lkarnet/models/shop/shop_model.dart';

import '../../repository/database_operations.dart';

part 'shops_event.dart';
part 'shops_state.dart';

class ShopsBloc extends Bloc<ShopsEvent, ShopsState> {
  late final DatabaseOperations _databaseOperations;
  StreamSubscription<List<ShopModel>>? _itemsSubscription;
  ShopsBloc(DatabaseOperations databaseOperations) : super(ShopsInitial()) {
    this._databaseOperations = databaseOperations;
    on<ShopsEvent>((event, emit) {});
    on<GetShopsEvent>(_onGetShops);
    on<LoadShopsEvent>(_onLoadShops);
    on<AddShopEvent>((event, emit) {
      _databaseOperations.addShop(event.shop);
      add(GetShopsEvent());
    });
  }

  /// onloadshops event
  void _onLoadShops(LoadShopsEvent event, Emitter<ShopsState> emit) async {
    emit(ShopsLoaded(event.shops));
  }

  /// on get shops event
  Future<void> _onGetShops(ShopsEvent event, Emitter<ShopsState> emit) async {
    // if (_itemsSubscription != null) {
    //   _itemsSubscription!.cancel();
    // }
    _itemsSubscription = _databaseOperations
        .shopsStream()
        .listen((shops) => add(LoadShopsEvent(shops)));
  }
}
