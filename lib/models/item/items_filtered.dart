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
  List<String> get distinctItemNames =>
      items.map((item) => item.itemName).toSet().toList();

  // get distinct ddmmyyyy
  List<DateTime> get distinctDays => items
      .map((item) => DateTime(
          item.dateBought.day, item.dateBought.month, item.dateBought.year))
      .toSet()
      .toList();

  // get distinct mmyyy from items
  List<DateTime> get distinctMonths => items
      .map((item) => DateTime(item.dateBought.year, item.dateBought.month, 1))
      .toSet()
      .toList();

// get distinct yyyy
  List<DateTime> get distinctYears => items
      .map((item) => DateTime(item.dateBought.year, 1, 1))
      .toSet()
      .toList();

// get all items for today
  List<ItemModel> get allItemsToday {
    return items
        .where((element) => element.dateBought.isMatchDay(DateTime.now()))
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

  /// methods with parameters
  itemsForDate(DateTime date) {
    return items
        .where((element) => element.dateBought.isMatchDay(date))
        .toList();
  }

  /// methods with parameters
  itemsForMonth(DateTime date) {
    return items
        .where((element) => element.dateBought.isMatchToMonth(date))
        .toList();
  }

  /// methods with parameters
  itemsForYear(DateTime date) {
    return items
        .where((element) => element.dateBought.isMatchToYear(date))
        .toList();
  }
}
