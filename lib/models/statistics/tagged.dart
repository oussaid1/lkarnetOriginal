import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/item/items_filtered.dart';
import 'package:lkarnet/models/item_distincts.dart';
import 'package:lkarnet/models/payment/payments_filtered.dart';
import 'package:lkarnet/models/shop/shop_model.dart';
import 'package:lkarnet/models/shop/shops_data.dart';
import 'package:lkarnet/providers/streamproviders/items_stream_provider.dart';
import 'package:lkarnet/providers/streamproviders/payments_stream_provider.dart';
import 'package:lkarnet/providers/streamproviders/shops_stream_provider.dart';

final taggedListDDMMYYProvider = StateProvider<List<Tagged>>((ref) {
  List<Tagged> _list = [];
  var _distincts = ref.watch(itemDistinctsProvider.state).state;
  var _items = ref.watch(itemsProvider.state).state;
  var _payments = ref.watch(paymentsProvider.state).state;
  var _shops = ref.watch(shopsProvider.state).state;
  _distincts.distinctItemDays.forEach((tag) {
    _list.add(
      Tagged(
        tag: tag,
        dateFilterType: DateFilterType.ddmmyy,
        shops: _shops,
        itemsFiltered: ItemsFiltered(
          items: _items,
          tag: tag,
          dateFilterType: DateFilterType.ddmmyy,
        ),
        paymentsFiltered: PaymentsFiltered(
          payments: _payments,
          tag: tag,
          dateFilterType: DateFilterType.ddmmyy,
        ),
      ),
    );
  });
  return _list;
});
final taggedListMMYYProvider = StateProvider<List<Tagged>>((ref) {
  List<Tagged> _list = [];
  var distincts = ref.watch(itemDistinctsProvider.state).state;
  var items = ref.watch(itemsProvider.state).state;
  var payments = ref.watch(paymentsProvider.state).state;
  var shops = ref.watch(shopsProvider.state).state;
  distincts.itemsDistinctItemMonthsYrs.forEach((tag) {
    _list.add(Tagged(
        tag: tag,
        dateFilterType: DateFilterType.mmyy,
        shops: shops,
        itemsFiltered: ItemsFiltered(
          items: items,
          tag: tag,
          dateFilterType: DateFilterType.mmyy,
        ),
        paymentsFiltered: PaymentsFiltered(
          payments: payments,
          tag: tag,
          dateFilterType: DateFilterType.mmyy,
        )));
  });
  return _list;
});

class Tagged {
  String tag = 'Unknown';
  ItemsFiltered itemsFiltered;
  PaymentsFiltered paymentsFiltered;
  List<ShopModel> shops;
  DateFilterType dateFilterType;
  List<ShopData> get shopData {
    List<ShopData> _list = [];
    shops.forEach((shop) => _list.add(new ShopData(
        shop,
        new ItemsFiltered(
            tag: tag,
            dateFilterType: dateFilterType,
            items: itemsFiltered.allItems
                .where((item) => item.shopName == shop.shopName)
                .toList()),
        new PaymentsFiltered(
            tag: tag,
            dateFilterType: dateFilterType,
            payments: paymentsFiltered.allPayments
                .where((payment) => payment.paidShopName == shop.shopName)
                .toList()))));
    // _list.retainWhere((element) => element.countItems != 0);
    _list.sort(
        (a, b) => b.itemsSumAfterPayment.compareTo(a.itemsSumAfterPayment));
    return _list;
  }

  List<ShopData> get shopDataList {
    return shopData
        .where((element) => element.itemsSumAfterPayment != 0)
        .toList();
  }

  Tagged({
    required this.tag,
    required this.dateFilterType,
    required this.shops,
    required this.itemsFiltered,
    required this.paymentsFiltered,
  });

  double get itemsSum {
    double _x = 0;
    _x = itemsFiltered.allItems
        .fold(0, (previousValue, element) => previousValue + element.itemPrix);
    return _x;
  }

  double get itemsSumAfterPayment {
    double _x = 0;
    _x = itemsSum - paymentsSum;
    return _x;
  }

  int get countItems {
    int _x = 0;
    itemsFiltered.allItems.forEach((element) => _x += element.count);
    return _x;
  }

  double get paymentsSum {
    double _x = 0;
    _x = paymentsFiltered.allPayments
        .fold(0, (previousValue, element) => previousValue + element.paid);
    return _x;
  }

  int get countPayments {
    int _x = 0;
    paymentsFiltered.allPayments.forEach((element) => _x += element.count);
    return _x;
  }
}
