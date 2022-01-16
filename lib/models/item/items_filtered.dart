import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lkarnet/providers/streamproviders/items_stream_provider.dart';

import 'item.dart';

final itemsFilteredProvider = StateProvider<ItemsFiltered>((ref) {
  var items = ref.watch(itemsProvider.state).state;
  return new ItemsFiltered(items: items);
});
enum DateFilterType { ddmmyy, mmyy, yy }

class ItemsFiltered {
  List<Item> items;
  String? tag;
  DateFilterType? dateFilterType;
  ItemsFiltered({required this.items, this.tag, this.dateFilterType});

  List<Item> get allItems {
    if (dateFilterType == DateFilterType.ddmmyy) {
      return allItemByDDMMYYTag;
    } else if (dateFilterType == DateFilterType.mmyy) {
      return allItemByMMYYTag;
    } else if (dateFilterType == DateFilterType.yy) {
      return allItemByYYTag;
    }
    return items;
  }

  List<Item> get allItemByDDMMYYTag {
    return items.where((item) => item.toDDMMYY == tag).toList();
  }

  List<Item> get allItemByMMYYTag {
    return items.where((item) => item.toMMYY == tag).toList();
  }

  List<Item> get allItemByYYTag {
    return items.where((item) => item.toYY == tag).toList();
  }

// get all items for today
  List<Item> get allItemsToday {
    return items
        .where((element) => element.dateBought.day == DateTime.now().day)
        .toList();
  }

  List<Item> get allItemsThisMonth {
    return items
        .where((element) => element.dateBought.month == DateTime.now().month)
        .toList();
  }

  List<Item> get allItemsThisYear {
    return items
        .where((element) => element.dateBought.year == DateTime.now().year)
        .toList();
  }

  int toCount(List<Item> items) =>
      items.fold(0, (previousValue, element) => previousValue + element.count);
  double toSum(List<Item> items) => items.fold(
      0, (previousValue, element) => previousValue + element.itemPrix);

  ItemsFiltered copyWith({
    List<Item>? allItems,
    String? tag,
    DateFilterType? dateFilterType,
  }) {
    return ItemsFiltered(
        items: allItems ?? this.items,
        tag: tag ?? this.tag,
        dateFilterType: dateFilterType ?? this.dateFilterType);
  }
}
