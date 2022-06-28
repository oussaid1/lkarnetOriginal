import 'package:lkarnet/components.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/models/item/items_filtered.dart';
import 'package:lkarnet/models/payment/payment_model.dart';
import 'package:lkarnet/models/payment/payments_filtered.dart';
import 'package:lkarnet/providers/streamproviders/items_stream_provider.dart';
import 'package:lkarnet/providers/streamproviders/payments_stream_provider.dart';
import 'package:lkarnet/providers/streamproviders/shops_stream_provider.dart';
import '../item/items_data.dart';
import 'shop_model.dart';

final shopsDataListProvider = StateProvider<List<ShopData>>((ref) {
  List<ShopData> list = [];
  final items = ref.watch(itemsProvider.state);
  final payments = ref.watch(paymentsProvider.state).state;
  final shops = ref.watch(shopsProvider.state);
  shops.state.forEach((shop) => list.add(new ShopData(
      shop,
      new ItemsFiltered(
          items: items.state
              .where((item) => item.shopName == shop.shopName)
              .toList()),
      new PaymentsFiltered(
          payments: payments
              .where((payment) => payment.paidShopName == shop.shopName)
              .toList()))));
  list.sort((a, b) => b.itemsSumAfterPayment.compareTo(a.itemsSumAfterPayment));
  return list;
});

class ShopData {
  ShopModel shop;
  ItemsFiltered itemsFiltered;
  PaymentsFiltered paymentsFiltered;
  ShopData(this.shop, this.itemsFiltered, this.paymentsFiltered);

  // filtered list by Shop object passed to the constructor
  List<ItemModel> get allItems {
    return itemsFiltered.allItems
        .where((element) => element.shopName == shop.shopName)
        .toList();
  }

  List<PaymentModel> get allPayments {
    return paymentsFiltered.payments
        .where((element) => element.paidShopName == shop.shopName)
        .toList();
  }

// get distinct item names

// all items for current shop in the form of Statistics

  double get itemsSum {
    double _x = 0;
    _x = allItems.fold(
        0, (previousValue, element) => previousValue + element.itemPrix);
    return _x;
  }

  double get itemsSumAfterPayment {
    double _x = 0;
    _x = itemsSum - paymentsSum;
    return _x;
  }

  int get countItems {
    int _x = 0;
    allItems.forEach((element) => _x += element.count);
    return _x;
  }

  double get paymentsSum {
    double _x = 0;
    _x = allPayments.fold(
        0, (previousValue, element) => previousValue + element.paid);
    return _x;
  }

  int get countPayments {
    int _x = 0;
    allPayments.forEach((element) => _x += element.count);
    return _x;
  }

  ItemsData get itemsData {
    return ItemsData(items: itemsFiltered.allItems);
  }
}

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
    shops.forEach((shop) => list.add(new ShopData(
        shop,
        new ItemsFiltered(
            items: items
                .where((element) => element.shopName == shop.shopName)
                .toList()),
        new PaymentsFiltered(
            payments: payments
                .where((element) => element.paidShopName == shop.shopName)
                .toList()))));
    list.sort(
        (a, b) => b.itemsSumAfterPayment.compareTo(a.itemsSumAfterPayment));
    return list;
  }

  double get itemsSum {
    return items.fold(0, (sum, item) => sum + item.itemPrix);
  }

  double get itemsSumAfterPayment {
    return itemsSum - paymentsSum;
  }

  int get countItems {
    int _x = 0;
    items.forEach((element) => _x += element.count);
    return _x;
  }

  double get paymentsSum {
    return payments.fold(0, (sum, payment) => sum + payment.paidAmount);
  }

  int get countPayments {
    int _x = 0;
    payments.forEach((element) => _x += element.count);
    return _x;
  }

  // get percentage between paymentsSum and itemsSum
  double get spendingsUnitinterval {
    double _percentage = 0;
    if (itemsSum > 0) {
      _percentage = paymentsSum / itemsSum;
    }
    if (_percentage > 1) {
      return 1.0;
    }
    if (_percentage < 0) {
      return 0;
    }
    return _percentage;
  }

  double get spendingsPecentage {
    double _percentage = 0;
    if (itemsSum > 0) {
      _percentage = (paymentsSum * 100) / itemsSum;
    }
    _percentage;
    if (_percentage > 100) {
      return 1.0;
    }
    if (_percentage < 0) {
      return 0;
    }
    return _percentage.toPrecision();
  }

  // get itemsData
  ItemsData get itemsDataForAll {
    return ItemsData(items: items);
  }
}
