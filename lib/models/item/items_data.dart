import '../statistics/statistics_model.dart';
import 'item.dart';
import 'package:lkarnet/components.dart';

class ItemsData {
  List<Item> items;
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

  // get distinct mmyyy from items
  List<String> get mmyyyDistincts {
    var _list = <String>[];
    for (var item in items) {
      _list.add(item.dateBought.mmyyyy());
    }
    return _list.toSet().toList();
  }

  // get distinct ddmmyyyy
  List<String> get ddmmyyyDistincts {
    var _list = <String>[];
    for (var item in items) {
      _list.add(item.dateBought.ddmmyyyy());
    }
    return _list.toSet().toList();
  }

// get distinct yyyy
  List<String> get yyyDistincts {
    var _list = <String>[];
    for (var item in items) {
      _list.add(item.dateBought.ddmmyyyy());
    }
    return _list.toSet().toList();
  }

// get mmyyy ItemsData
  List<ItemsData> get mmyyyItemsChartData {
    var _list = <ItemsData>[];
    for (var distinctItem in mmyyyDistincts) {
      _list.add(ItemsData(
          items: items
              .where((element) => element.dateBought.mmyyyy() == distinctItem)
              .toList()));
    }
    return _list;
  }

  // get how many items for each itemName
  List<ItemsChartData> get countSumItems {
    var map = {};
    int count = 1;
    var sum = 0.0;
    var _lista = <ItemsChartData>[];

    for (Item element in items) {
      if (!map.containsKey(element.itemName)) {
        map[element.itemName] = {'count': 1, 'sum': element.itemPrix};
      } else {
        count = map[element.itemName]['count'] + 1;
        sum = map[element.itemName]['sum'] + element.itemPrix;
        map[element.itemName] = {'count': count, 'sum': sum};
      }
    }

    map.forEach((key, element) {
      _lista.add(ItemsChartData(
          itemName: key,
          itemCount: element['count'],
          itemPrix: element['sum']));
    });
    //_lista.sort((b, a) => a.sumAll.compareTo(b.sumAll));
    // if (_lista.length >= 17) return _lista.sublist(0, 17);
    return _lista;
  }

  // get 10 most frequent items
  List<ItemsChartData> getMostFrequentItems() {
    countSumItems.sort((a, b) => b.itemCount!.compareTo(a.itemCount!));
    if (countSumItems.length >= 10) {
      return countSumItems.sublist(0, 10);
    }
    return countSumItems;
  }

  // get 10 most expensive items
  List<ItemsChartData> getMostExpensiveItems() {
    countSumItems.sort((a, b) => b.itemPrix!.compareTo(a.itemPrix!));
    if (countSumItems.length >= 10) {
      return countSumItems.sublist(0, 10);
    }
    return countSumItems;
  }
}
