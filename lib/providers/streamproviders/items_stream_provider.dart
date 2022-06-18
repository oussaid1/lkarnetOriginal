import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/providers/authproviders/database_providers.dart';

import '../../screens/lists/items.dart';

final itemsStream = StreamProvider<List<ItemModel>>((ref) {
  final _db = ref.watch(databaseProvider);
  return _db.itemStream();
});

final itemsProvider = StateProvider<List<ItemModel>>((ref) {
  final stream = ref.watch(itemsStream);
  return stream.maybeWhen(data: (items) => items, orElse: () => []);
});

final itemsListNotifierProvider =
    StateProvider.family<List<ItemModel>, List<ItemModel>>((ref, list) {
  final _kitchenElementsItems = list; //ref.watch(itemsProvider.state).state;
  var _filterPattern = ref.watch(filterPatternProvider.state).state;
  var _filterType = ref.watch(filterTypeProvider.state).state;
  switch (_filterType) {
    case FilterType.all:
      return _kitchenElementsItems
          .where((element) => element.itemName
              .toLowerCase()
              .contains(_filterPattern.toLowerCase()))
          .toList();
    case FilterType.byName:
      return _kitchenElementsItems
          .where((element) => element.itemName
              .toLowerCase()
              .contains(_filterPattern.toLowerCase()))
          .toList();
    case FilterType.byCategory:
      return _kitchenElementsItems
          .where((element) => element.besoinTitle!
              .toLowerCase()
              .contains(_filterPattern.toLowerCase()))
          .toList();
    case FilterType.byPrice:
      return _kitchenElementsItems
          .where((element) => element.itemPrice
              .toString()
              .contains(_filterPattern.toLowerCase()))
          .toList();
    case FilterType.byQuantity:
      return _kitchenElementsItems
          .where((element) => element.quantity
              .toString()
              .contains(_filterPattern.toLowerCase()))
          .toList();
    default:
      return _kitchenElementsItems;
  }
});

enum FilterType {
  all,
  byCategory,
  byName,
  byPrice,
  byQuantity,
  byDate,
  byShop,
}

class ItemsListNotifier extends ChangeNotifier {
  ItemsListNotifier(this.itemsList, this.filterPattern, this.filterType) {
    itemsList.isEmpty ? itemsList = fakeitemsList : itemsList;
  }
  FilterType filterType = FilterType.all;
  String filterPattern;
  List<ItemModel> itemsList = [];
  List<ItemModel> fakeitemsList = [];

  // add item to list
  void addItem(ItemModel value) {
    itemsList.add(value);
    // state.add(value);
    notifyListeners();
  }

  // remove item from list
  void removeItem(int index) {
    itemsList.removeAt(index);
    //state.remove(value);
    notifyListeners();
  }
}
