import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/providers/authproviders/database_providers.dart';

final itemsStream = StreamProvider<List<Item>>((ref) {
  final _db = ref.watch(databaseProvider);
  return _db.itemStream();
});

final itemsProvider = StateProvider<List<Item>>((ref) {
  final stream = ref.watch(itemsStream);
  return stream.maybeWhen(data: (items) => items, orElse: () => []);
});

final itemsListNotifierProvider =
    ChangeNotifierProvider<ItemsListNotifier>((ref) {
  final _kitchenElementsItems = ref.watch(itemsProvider.state).state;
  return ItemsListNotifier(_kitchenElementsItems, '', FilterType.all);
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
  List<Item> itemsList = [];
  List<Item> fakeitemsList = [];
// return itemsList according to filterPattern
  List<Item> get itemsListFiltered {
    switch (filterType) {
      case FilterType.all:
        return itemsList;
      case FilterType.byCategory:
        return itemsList
            .where((element) =>
                element.besoinTitle!.toLowerCase() == filterPattern)
            .toList();
      case FilterType.byName:
        return itemsList
            .where((element) => element.itemName.toLowerCase() == filterPattern)
            .toList();
      case FilterType.byPrice:
        return itemsList
            .where((element) =>
                element.itemPrix.toString().toLowerCase() == filterPattern)
            .toList();
      case FilterType.byQuantity:
        return itemsList
            .where((element) =>
                element.quantity.toString().toLowerCase() == filterPattern)
            .toList();
      case FilterType.byDate:
        return itemsList
            .where((element) => element.dateBought.toString() == filterPattern)
            .toList();
      case FilterType.byShop:
        return itemsList
            .where((element) => element.shopName.toLowerCase() == filterPattern)
            .toList();
      default:
        return itemsList;
    }
  }

  // add item to list
  void addItem(Item value) {
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
