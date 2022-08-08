import '../statistics/statistics_model.dart';
import 'item.dart';
import 'package:lkarnet/components.dart';

class ItemsData {
  List<ItemModel> items;
  ItemsData({required this.items});
// compare two Strings and check number of matching letters
  int compareStrings(String a, String b) {
    int count = 0;
    for (int i = 0; i < a.length; i++) {
      if (a[i] == b[i]) {
        count++;
      }
    }
    return count;
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

// get mmyyy ItemsData
  List<ItemsChartData> get ddmmyyyyItemsData {
    var _list = <ItemsChartData>[];
    for (var i = 0; i < distinctDays.length; i++) {
      _list.add(ItemsChartData(
          tag: distinctDays[i].ddmmyyyy(),
          items: items
              .where((element) => element.dateBought.isAs(distinctDays[i]))
              .toList()));
    }
    return _list;
  }

  // get mmyyy ItemsData
  List<ItemsChartData> get mmyyyItemsData {
    var _list = <ItemsChartData>[];
    for (var i = 0; i < distinctMonths.length; i++) {
      _list.add(ItemsChartData(
          tag: distinctMonths[i].ddmmyyyy(),
          items: items
              .where((element) => element.dateBought.isAs(distinctMonths[i]))
              .toList()));
    }
    return _list;
  }

  // get yyyy ItemsData
  List<ItemsChartData> get yyyyItemsData {
    var _list = <ItemsChartData>[];
    for (var i = 0; i < distinctYears.length; i++) {
      _list.add(ItemsChartData(
          tag: distinctYears[i].ddmmyyyy(),
          items: items
              .where((element) => element.dateBought.isAs(distinctYears[i]))
              .toList()));
    }
    return _list;
  }

  //// get chartData for each item name
  List<ItemsChartData> get itemNameChartData {
    var _list = <ItemsChartData>[];
    for (var i = 0; i < distinctItemNames.length; i++) {
      _list.add(ItemsChartData(
          tag: distinctItemNames[i],
          items: items
              .where((element) =>
                  element.itemName.trim() == distinctItemNames[i].trim())
              .toList()));
    }
    return _list;
  }

////////////////////////////////////////////////////
///////////////////////////////////////////////////
  /// get this most recent items bought
  List<ItemModel> get mostRecentItems {
    if (items.length == 0) {
      return [];
    }
    DateTime mostRecent = items[0].dateBought;
    return items
        .where((element) => element.dateBought.isMatchToday(mostRecent))
        .toList();
  }
}
