import 'dart:ui';

import '../item/item.dart';
import '../item/item_calculations.dart';

class ItemsChartData {
  ItemsChartData(
      {required this.tag, this.value, required this.items, this.color});
  final String tag;
  final double? value;
  final List<ItemModel>? items;
  final Color? color;
  DateTime? date;

  //////// get ItemCalculations /////////////////////////////////
  ItemCalculations get itemCalculations => ItemCalculations(items: items ?? []);
}
