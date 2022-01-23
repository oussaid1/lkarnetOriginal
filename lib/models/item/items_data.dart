import '../statistics/statistics_model.dart';
import 'item.dart';

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

  // get how many items for each itemName
  List<ItemsChartData> getCountSumItems() {
    var mapCount = {};
    var map2 = {};
    var _lista = <ItemsChartData>[];
    for (Item element in items) {
      if (!mapCount.containsKey(element.itemName)) {
        mapCount[element.itemName] = 1;
        map2[element.itemName] = element.itemPrix;
      } else {
        mapCount[element.itemName] += 1;
        map2[element.itemName] += element.itemPrix;
      }
    }
    ;
    mapCount.forEach((key, element) {
      _lista.add(ItemsChartData(
          itemName: key, itemCount: element, itemPrix: map2[key]));
    });
    //_lista.sort((b, a) => a.sumAll.compareTo(b.sumAll));
    // if (_lista.length >= 17) return _lista.sublist(0, 17);
    return _lista;
  }

  // get 10 most frequent items
  List<ItemsChartData> getMostFrequentItems() {
    getCountSumItems().sort((a, b) => b.itemCount!.compareTo(a.itemCount!));
    if (getCountSumItems().length >= 10) {
      return getCountSumItems().sublist(0, 10);
    }
    return getCountSumItems();
  }

  // get 10 most expensive items
  List<ItemsChartData> getMostExpensiveItems() {
    getCountSumItems().sort((a, b) => b.itemPrix!.compareTo(a.itemPrix!));
    if (getCountSumItems().length >= 10) {
      return getCountSumItems().sublist(0, 10);
    }
    return getCountSumItems();
  }
}
