import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/providers/streamproviders/items_stream_provider.dart';

import 'item/item.dart';

final itemDistinctsProvider = StateProvider<ItemDistincts>((ref) {
  return ItemDistincts(items: ref.watch(itemsProvider.state).state);
});

// get distincts from items
class ItemDistincts {
  List<ItemModel> items = [];
  ItemDistincts({
    required this.items,
  });
// comment this is to get distinct itemNames from items
  List<String> get distinctItemNames {
    List<String> _distincts = [];
    items.forEach((element) {
      _distincts.add(element.itemName.trim());
    });
    return _distincts.toSet().toList();
  }

  List<String> get distinctItemShops {
    List<String> _distincts = [];
    items.forEach((element) {
      _distincts.add(element.shopName);
    });
    return _distincts.toSet().toList();
  }

  List<String> get distinctItemDays {
    List<String> _distincts = [];
    items.forEach((element) => _distincts.add(element.toDDMMYY));
    return _distincts.toSet().toList();
  }

  List<String> get itemsDistinctItemMonthsYrs {
    List<String> _distincts = [];
    items.forEach((element) => _distincts.add(element.toMMYY));
    return _distincts.toSet().toList();
  }

  List<String> get distinctItemYears {
    List<String> _distincts = [];
    items.forEach((element) => _distincts.add(element.toDDMMYY));
    return _distincts.toSet().toList();
  }

  ItemDistincts copyWith({
    List<ItemModel>? items,
  }) {
    return ItemDistincts(
      items: items ?? this.items,
    );
  }
}
