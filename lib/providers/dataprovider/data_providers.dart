import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/shop/shops_data.dart';
import 'package:lkarnet/models/statistics/statistics_model.dart';

final frequentItemsProvider = StateProvider<List<ChartData>>((ref) {
  List<ChartData> list = [];
  var itemStats = ref.watch(itemStatisticsProvider.state).state;
  itemStats.forEach((element) {
    list.add(new ChartData(element.tag, element.itemsSum, element.countItems));
  });
  if (list.length > 10) {
    list.removeRange(10, list.length);
  }
  return list;
});

final shopsChartsDataProvider = StateProvider<List<ChartData>>((ref) {
  List<ChartData> list = [];
  var shopsData = ref.watch(shopsDataListProvider.state).state;
  shopsData.forEach((element) {
    list.add(new ChartData(element.shop.shopName.toString(),
        element.itemsSumAfterPayment, element.countItems));
  });
  return list;
});
