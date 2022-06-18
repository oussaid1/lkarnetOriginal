import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lkarnet/providers/streamproviders/items_stream_provider.dart';

import 'item.dart';

final itemsFilteredProvider = StateProvider<ItemsFiltered>((ref) {
  var items = ref.watch(itemsProvider.state).state;
  return new ItemsFiltered(items: items);
});

enum DateFilterType { ddmmyy, mmyy, yy }

class ItemsFiltered {
  List<ItemModel> items;
  String? tag;
  DateFilterType? dateFilterType;
  ItemsFiltered({required this.items, this.tag, this.dateFilterType});

  List<ItemModel> get allItems {
    if (dateFilterType == DateFilterType.ddmmyy) {
      return allItemByDDMMYYTag;
    } else if (dateFilterType == DateFilterType.mmyy) {
      return allItemByMMYYTag;
    } else if (dateFilterType == DateFilterType.yy) {
      return allItemByYYTag;
    }
    return items;
  }

  List<ItemModel> get allItemByDDMMYYTag {
    return items.where((item) => item.toDDMMYY == tag).toList();
  }

  List<ItemModel> get allItemByMMYYTag {
    return items.where((item) => item.toMMYY == tag).toList();
  }

  List<ItemModel> get allItemByYYTag {
    return items.where((item) => item.toYY == tag).toList();
  }

// get all items for today
  List<ItemModel> get allItemsToday {
    return items
        .where((element) => element.dateBought.day == DateTime.now().day)
        .toList();
  }

  List<ItemModel> get allItemsThisMonth {
    return items
        .where((element) => element.dateBought.month == DateTime.now().month)
        .toList();
  }

  List<ItemModel> get allItemsThisYear {
    return items
        .where((element) => element.dateBought.year == DateTime.now().year)
        .toList();
  }

  int toCount(List<ItemModel> items) =>
      items.fold(0, (previousValue, element) => previousValue + element.count);
  double toSum(List<ItemModel> items) => items.fold(
      0, (previousValue, element) => previousValue + element.itemPrix);

  ItemsFiltered copyWith({
    List<ItemModel>? allItems,
    String? tag,
    DateFilterType? dateFilterType,
  }) {
    return ItemsFiltered(
        items: allItems ?? this.items,
        tag: tag ?? this.tag,
        dateFilterType: dateFilterType ?? this.dateFilterType);
  }
}
