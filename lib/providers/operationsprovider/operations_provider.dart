import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/models/payment/payment_model.dart';
import 'package:lkarnet/models/shop/shop_model.dart';
import 'package:lkarnet/models/shop/shops_data.dart';
import 'package:lkarnet/providers/authproviders/database_providers.dart';
import 'package:lkarnet/providers/varproviders/add_item_provider.dart';
import 'package:lkarnet/providers/varproviders/add_payment.dart';
import 'package:lkarnet/providers/varproviders/add_shop_provider.dart';
import 'package:lkarnet/providers/varproviders/var_providers.dart';

final operationsProvider = Provider<Operations>((ref) {
  return Operations((ref.read));
});

class Operations {
  final Reader _read;

  Operations(this._read);

  Future<bool> addItem() async {
    final _item = Item(
      besoinTitle: itemBesoinTitle,
      dateBought: selectedDateTime,
      itemName: itemName,
      itemPrice: itemPrice,
      quantifier: selectedQuantifier,
      quantity: quantity,
      shopName: selectedShop,
    );
    _item.toPrint();
    return await _read(databaseProvider).addItem(_item).then((value) => true);
  }

  Future<bool> updateItem(String id) async {
    final _item = Item(
      id: id,
      besoinTitle: itemBesoinTitle,
      dateBought: selectedDateTime,
      itemName: itemName,
      itemPrice: itemPrice,
      quantifier: selectedQuantifier,
      quantity: quantity,
      shopName: selectedShop,
    );
    return await _read(databaseProvider)
        .updateItem(_item)
        .then((value) => true);
  }

  Future<bool> deleteItem(Item item) async {
    return await _read(databaseProvider).deleteItem(item).then((value) => true);
  }

  Future<bool> addShop() async {
    final _shop = ShopModel(
      besoinTitle: slectedShopBesoinTitle,
      shopName: shopName,
      email: shopEmail,
      phone: shopPhone,
      limit: shopLimit,
    );
    return await _read(databaseProvider).addShop(_shop).then((value) => true);
  }

  Future<bool> updateShop(String id) async {
    final _shop = ShopModel(
      id: id,
      besoinTitle: slectedShopBesoinTitle,
      shopName: shopName,
      email: shopEmail,
      limit: shopLimit,
      phone: shopPhone,
    );
    return await _read(databaseProvider)
        .updateShop(_shop)
        .then((value) => true);
  }

  Future<bool> deleteShop(ShopModel shop) async {
    return await _read(databaseProvider).deleteShop(shop).then((value) => true);
  }

  Future<bool> addPayment() async {
    final _payment = Payment(
      datePaid: selectedDateTime,
      paidAmount: paidAmount,
      paidShopName: selectedShop,
      besoinTitle: slectedShopBesoinTitle,
    );
    return await _read(databaseProvider)
        .addPayment(_payment)
        .then((value) => true);
  }

  Future<bool> updatePayment(String id) async {
    final _payment = Payment(
      id: id,
      datePaid: selectedDateTime,
      paidAmount: paidAmount,
      paidShopName: selectedShop,
      besoinTitle: slectedShopBesoinTitle,
    );
    return await _read(databaseProvider)
        .updatePayment(_payment)
        .then((value) => true);
  }

  Future<bool> deletePayment(Payment payment) async {
    return await _read(databaseProvider)
        .deletePayment(payment)
        .then((value) => true);
  }
  Future<bool> deleteShopData(ShopsData shopsData) async {
    deleteShop(shopsData.shop);
    for(var item in shopsData.allItems){deleteItem(item);}
    for(var payment in shopsData.allPayments){deletePayment(payment);}
   return true;
  }
}
