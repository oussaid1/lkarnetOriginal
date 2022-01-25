import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/models/payment/payment_model.dart';
import 'package:lkarnet/models/shop/shop_model.dart';
import 'package:lkarnet/models/shop/shops_data.dart';
import 'package:lkarnet/providers/authproviders/database_providers.dart';

final operationsProvider = Provider<Operations>((ref) {
  return Operations((ref.read));
});

class Operations {
  final Reader _read;

  Operations(this._read);

  Future<bool> addItem(Item _item) async {
    _item.toPrint();
    return await _read(databaseProvider).addItem(_item).then((value) => true);
  }

  Future<bool> updateItem(Item _item) async {
    return await _read(databaseProvider)
        .updateItem(_item)
        .then((value) => true);
  }

  Future<bool> deleteItem(Item item) async {
    return await _read(databaseProvider).deleteItem(item).then((value) => true);
  }

  Future<bool> addShop(ShopModel shopModel) async {
    return await _read(databaseProvider)
        .addShop(shopModel)
        .then((value) => true);
  }

  Future<bool> updateShop(ShopModel shopModel) async {
    return await _read(databaseProvider)
        .updateShop(shopModel)
        .then((value) => true);
  }

  Future<bool> deleteShop(ShopModel shop) async {
    return await _read(databaseProvider).deleteShop(shop).then((value) => true);
  }

  Future<bool> addPayment(Payment payment) async {
    return await _read(databaseProvider)
        .addPayment(payment)
        .then((value) => true);
  }

  Future<bool> updatePayment(Payment payment) async {
    return await _read(databaseProvider)
        .updatePayment(payment)
        .then((value) => true);
  }

  Future<bool> deletePayment(Payment payment) async {
    return await _read(databaseProvider)
        .deletePayment(payment)
        .then((value) => true);
  }

  Future<bool> deleteShopData(ShopsData shopsData) async {
    deleteShop(shopsData.shop);
    for (var item in shopsData.allItems) {
      deleteItem(item);
    }
    for (var payment in shopsData.allPayments) {
      deletePayment(payment);
    }
    return true;
  }
}
