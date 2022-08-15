import 'package:lkarnet/models/item/items_filtered.dart';
import 'package:lkarnet/models/payment/payments_filtered.dart';
import 'package:lkarnet/models/statistics/tagged.dart';

import 'item/item.dart';
import 'payment/payment_model.dart';
import 'shop/shop_model.dart';
import 'shop/shops_data.dart';

class DataSink {
  List<ShopModel> shops;
  List<ItemModel> items;
  List<PaymentModel> payments;
  DataSink(this.shops, this.items, this.payments);

  /// copy with
  DataSink copyWith({
    List<ShopModel>? shops,
    List<ItemModel>? items,
    List<PaymentModel>? payments,
  }) {
    return DataSink(
      shops ?? this.shops,
      items ?? this.items,
      payments ?? this.payments,
    );
  }

  // get all shopsData
  List<ShopData> get allShopsData {
    List<ShopData> list = [];
    for (var shop in shops) {
      list.add(ShopData(
        shop: shop,
        items: items,
        payments: payments,
      ));
    }
    return list;
  }

  /////////////////////////////////////////////////////////////////
  /// get filtered items
  ItemsFiltered get filteredItems => ItemsFiltered(items: items);

  // get filtered payments
  PaymentsFiltered get filteredPayments => PaymentsFiltered(payments: payments);

  /// /////////////////////////////////////////////////////////////////
  /// distinct shopnames
  List<String> get shopNames =>
      shops.map((shop) => shop.shopName.toString()).toList();

  /// get a list of distinct dates from payments and items
  List<DateTime> get distinctDates {
    List<DateTime> list = [];
    list.addAll(filteredItems.distinctDays);
    list.addAll(filteredPayments.distinctDates);
    return list..toSet().toList();
  }

  // get distinct months from items and payments

  List<DateTime> get distinctMonths {
    List<DateTime> list = [];
    list.addAll(filteredItems.distinctMonths);
    list.addAll(filteredPayments.distinctMonths);
    return list..toSet().toList();
  }

  // get distinct years from items and payments
  List<DateTime> get distinctYears {
    List<DateTime> list = [];
    list.addAll(filteredItems.distinctYears);
    list.addAll(filteredPayments.distinctYears);
    return list..toSet().toList();
  }

  /////////////////////////////////////////////////////////////////
  ///get a list of tagged distinct dates from payments and items
  List<Tagged> get taggedDistinctDates {
    List<Tagged> list = [];
    for (var i = 0; i < distinctDates.length; i++) {
      list.add(Tagged(
        tag: distinctDates[i],
        shops: shops,
        items: filteredItems.itemsForDate(distinctDates[i]),
        payments: filteredPayments.paymentsForDate(distinctDates[i]),
      ));
    }

    return list;
  }

  // get tagged distinct months from items and payments
  List<Tagged> get taggedDistinctMonths {
    List<Tagged> list = [];
    for (var i = 0; i < distinctMonths.length; i++) {
      list.add(Tagged(
        tag: distinctMonths[i],
        shops: shops,
        items: filteredItems.itemsForMonth(distinctMonths[i]),
        payments: filteredPayments.paymentsForMonth(distinctMonths[i]),
      ));
    }

    return list;
  }

  // get tagged distinct years from items and payments
  List<Tagged> get taggedDistinctYears {
    List<Tagged> list = [];
    for (var i = 0; i < distinctYears.length; i++) {
      list.add(Tagged(
        tag: distinctYears[i],
        shops: shops,
        items: filteredItems.itemsForYear(distinctYears[i]),
        payments: filteredPayments.paymentsForYear(distinctYears[i]),
      ));
    }

    return list;
  }

  /// get a list of tagged for each shop
  List<Tagged> get taggedShops {
    List<Tagged<String>> list = [];
    for (var i = 0; i < shopNames.length; i++) {
      list.add(Tagged(
        tag: shops[i].shopName!,
        shops: shops,
        items: items
            .where((element) => element.shopName.trim() == shopNames[i].trim())
            .toList(),
        payments: payments
            .where((element) =>
                element.paidShopName!.trim() == shopNames[i].trim())
            .toList(),
      ));
    }

    return list;
  }
}
