import 'package:lkarnet/components.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/models/payment/payment_model.dart';
import '../item/items_data.dart';
import 'shop_model.dart';

class ShopData {
  ShopModel shop;
  List<ItemModel> items;
  List<PaymentModel> payments;
  ShopData({required this.shop, required this.items, required this.payments});
  /////////////////////////////////////////////////////////////////
  /// get an inctance of shopdata calculations
  ShopDataCalculations get shopDataCalculations =>
      ShopDataCalculations(items: items, payments: payments);

///////////////////////////////////////////////////////////////
  // get itemsData
  ItemsData get itemsDataForAll {
    return ItemsData(items: items);
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
    for (var shop in shops) {
      list.add(ShopData(
        shop: shop,
        items: items,
        payments: payments,
      ));
    }
    return list;
  }
}

class ShopDataCalculations {
  List<ItemModel> items;
  List<PaymentModel> payments;
  ShopDataCalculations({required this.items, required this.payments});
  /////////////////////////////////////////////////////////////////

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
    return _percentage.toPrecision(2);
  }
}
