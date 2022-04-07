import 'package:flutter/material.dart';
import 'package:lkarnet/components.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/providers/streamproviders/items_stream_provider.dart';

import '../item_distincts.dart';

final itemStatisticsProvider = StateProvider<List<ItemStatistics>>((ref) {
  List<ItemStatistics> list = [];
  var items = ref.watch(itemsProvider.state).state;
  var distincts = ref.watch(itemDistinctsProvider.state).state;
  distincts.distinctItemNames.forEach((dist) {
    list.add(ItemStatistics(
        dist, items.where((element) => element.itemName == dist).toList()));
  });
  list.sort((b, a) => a.itemsSum.compareTo(b.itemsSum));
  return list;
});

class ItemStatistics {
  String tag;
  List<String> distincts = [];
  List<Item> items = [];

  double get itemsSum {
    double _x = 0;
    _x = items.fold(
        0, (previousValue, element) => previousValue + element.itemPrix);
    return _x;
  }

  int get countItems {
    int _x = 0;
    items.forEach((element) => _x += element.count);
    return _x;
  }

  ItemStatistics(this.tag, this.items);
}

class ChartData {
  ChartData(this.tag, this.value, this.count, [this.color]);
  final String tag;
  final double value;
  final int count;
  final Color? color;
  DateTime? get date {
    List<String> date = tag.split('-');
    if (date.length == 3) {
      return DateTime.parse(tag);
    } else if (date.length == 2) {
      return DateTime.parse(date[0] + '-' + date[1] + '-01');
    } else if (date.length == 1) {
      return DateTime.parse(date[0] + '-01-01');
    }
    return null;
  }

  DateTime get tagDate {
    var date = DateTime.parse(tag);
    date.formatted();
    return date;
  }
}

class ItemsChartData {
  String? itemName;
  int? itemCount;
  double? itemPrix;
  ItemsChartData(
      {required this.itemName,
      required this.itemCount,
      required this.itemPrix});
}
