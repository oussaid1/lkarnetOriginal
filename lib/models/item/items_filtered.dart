import 'package:lkarnet/components.dart';
import 'package:lkarnet/providers/streamproviders/items_stream_provider.dart';
import 'item.dart';

final itemsFilteredProvider = StateProvider<ItemsFiltered>((ref) {
  var items = ref.watch(itemsProvider.state).state;
  return new ItemsFiltered(items: items);
});

enum DateFilter { all, today, thisweek, thismonth, thisyear }

class ItemsFiltered {
  List<ItemModel> items;
  String? tag;
  DateFilter? dateFilterType;
  ItemsFiltered({required this.items, this.tag, this.dateFilterType});

  List<ItemModel> get itemsByDateFilter {
    if (dateFilterType == DateFilter.today) {
      return allItemsToday;
    }
    if (dateFilterType == DateFilter.thisweek) {
      return allItemsThisWeek;
    }
    if (dateFilterType == DateFilter.thismonth) {
      return allItemsThisMonth;
    }
    if (dateFilterType == DateFilter.thisyear) {
      return allItemsThisYear;
    }

    return items;
  }

  //// get distinct item names ///////////////////////////////////////////////
  List<String> get distinctItemNames {
    List<String> distinctItemNames = [];
    for (ItemModel item in items) {
      distinctItemNames.add(item.itemName);
    }
    return distinctItemNames..toSet().toList();
  }

  // get distinct ddmmyyyy
  List<DateTime> get distinctDays {
    List<DateTime> ddmmyyyys = [];
    for (ItemModel item in items) {
      ddmmyyyys.add(DateTime(
          item.dateBought.year, item.dateBought.month, item.dateBought.day));
    }
    return ddmmyyyys..toSet().toList();
  }

  // get distinct mmyyy from items
  List<DateTime> get distinctMonths {
    var _list = <DateTime>[];
    for (var item in items) {
      _list.add(DateTime(item.dateBought.year, item.dateBought.month));
    }
    return _list.toSet().toList();
  }

// get distinct yyyy
  List<DateTime> get distinctYears {
    var _list = <DateTime>[];
    for (var item in items) {
      _list.add(DateTime(item.dateBought.year));
    }
    return _list.toSet().toList();
  }

// get all items for today
  List<ItemModel> get allItemsToday {
    return items
        .where((element) => element.dateBought.isMatchToday(DateTime.now()))
        .toList();
  }

  /// all items for this week
  List<ItemModel> get allItemsThisWeek {
    return items
        .where((element) => element.dateBought.isMatchToWeek(DateTime.now()))
        .toList();
  }

  List<ItemModel> get allItemsThisMonth {
    return items
        .where((element) => element.dateBought.isMatchToMonth(DateTime.now()))
        .toList();
  }

  List<ItemModel> get allItemsThisYear {
    return items
        .where((element) => element.dateBought.isMatchToYear(DateTime.now()))
        .toList();
  }
}
