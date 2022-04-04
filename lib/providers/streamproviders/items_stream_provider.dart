import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/providers/authproviders/database_providers.dart';

import '../../screens/lists/items.dart';

final itemsStream = StreamProvider<List<Item>>((ref) {
  final _db = ref.watch(databaseProvider);
  return _db.itemStream();
});

final itemsProvider = StateProvider<List<Item>>((ref) {
  final stream = ref.watch(itemsStream);
  return stream.maybeWhen(data: (items) => items, orElse: () => []);
});

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> af91a79 (thanks Allah)
final itemsListNotifierProvider = Provider<List<Item>>((ref) {
  final _kitchenElementsItems = ref.watch(itemsProvider.state).state;
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
=======
final itemsListNotifierProvider =
    ChangeNotifierProvider<ItemsListNotifier>((ref) {
  final _kitchenElementsItems = ref.watch(itemsProvider.state).state;
  return ItemsListNotifier(_kitchenElementsItems, '', FilterType.all);
<<<<<<< HEAD
>>>>>>> 336a080 (thanks Allah)
=======
final itemsListNotifierProvider = Provider<List<Item>>((ref) {
  final _kitchenElementsItems = ref.watch(itemsProvider.state).state;
  var _filterPattern = ref.watch(filterPatternProvider.state).state;
  var _filterType = ref.watch(filterTypeProvider.state).state;
  switch (_filterType) {
    case FilterType.all:
      return _kitchenElementsItems;
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
>>>>>>> a71c130 (...)
=======
>>>>>>> b369bdf (thanks Allah)
>>>>>>> af91a79 (thanks Allah)
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
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> af91a79 (thanks Allah)
=======
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
<<<<<<< HEAD
>>>>>>> 336a080 (thanks Allah)
=======
>>>>>>> a71c130 (...)
=======
>>>>>>> b369bdf (thanks Allah)
>>>>>>> af91a79 (thanks Allah)

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
