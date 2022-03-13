import 'package:lkarnet/Exception/custom_exception.dart';
import 'package:lkarnet/models/besoin/besoin.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/models/payment/payment_model.dart';
import 'package:lkarnet/models/shop/shop_model.dart';
import 'package:lkarnet/models/shop/shops_data.dart';
import 'package:lkarnet/models/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components.dart';
import '../models/kitchen/kitchen_item.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //final String _collection = 'users';
  final String _collectionKitchenElements = "KitchenElements";
  final String _collectionKitchenItems = "KitchenItems";
  DocumentReference get _users => _firestore.collection("users").doc(uid);
  final String? uid;
  Database({required this.uid});
  final logger = Logger();
  Future<bool> createNewUser(UserModel user) async {
    bool _done = false;
    await _firestore
        .collection('users')
        .doc(user.id)
        .set(user.toMap())
        .then((value) => _done = true)
        .catchError((error) {
      _done = false;
      print("Failed to add user: $error");
    });
    return _done;
  }

  Future<UserModel> getUser() async {
    return await _users
        .get()
        .then(
            (value) => UserModel.fromDocumentSnapshot(documentSnapshot: value))
        .catchError((e) => throw CustomException(message: '$e'));
  }

  // get
  Stream<List<Besoin>> besoinStream(String uid) {
    return _users.collection('Besoins').snapshots().map((QuerySnapshot query) {
      List<Besoin> retVal = [];
      query.docs.forEach((element) {
        retVal.add(Besoin.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<List<ShopModel>> shopsStream() {
    return _users.collection("Shops").snapshots().map((QuerySnapshot query) {
      List<ShopModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(ShopModel.fromDocumentSnapShot(element));
      });
      return retVal;
    });
  }

  Future<double> dayLimitFuture() async {
    return _users
        .collection("Variables")
        .doc('dayLimit')
        .get()
        .then((value) => value['dayLimit']);
  }

  Stream<List<Item>> itemStream() {
    return _users
        .collection("Goods")
        .orderBy("dateBought", descending: true)
        .snapshots()
        .map((QuerySnapshot query) => query.docs
            .map((element) => Item.fromDocumentSnapshot(element))
            .toList());
  }

// get kitchenElements
  Stream<List<KitchenElement>> kitchenStream() {
    return _users
        .collection(_collectionKitchenElements)
        .orderBy("dateBought", descending: true)
        .snapshots()
        .map((QuerySnapshot query) => query.docs
            .map((element) => KitchenElement.fromDocumentSnapShot(element))
            .toList());
  }

  // get kitchenItems
  Stream<List<KitchenItem>> kitchenItemsStream(
      String collectionKitchenElementId) {
    return _users
        .collection(_collectionKitchenElements)
        .doc(collectionKitchenElementId)
        .collection(_collectionKitchenItems)
        .orderBy("dateBought", descending: true)
        .snapshots()
        .map((QuerySnapshot query) => query.docs
            .map((element) => KitchenItem.fromDocumentSnapShot(element))
            .toList());
  }

  Stream<List<Item>> archiveItemStream() {
    return _users.collection("ArchiveGoods").snapshots().map(
        (QuerySnapshot query) => query.docs
            .map((element) => Item.fromDocumentSnapshot(element))
            .toList());
  }

  Stream<List<Payment>> streamPayments() {
    return _users.collection("Payments").snapshots().map((QuerySnapshot query) {
      List<Payment> retVal = [];
      for (var element in query.docs) {
        // logger.d(element.data());
        retVal.add(Payment.fromDocumentSnapshot(element));
      }
      // logger.d(retVal);
      // logger.d(retVal.length);
      return retVal;
    });
  }

// Add
  Future<void> addBesoin(Besoin besoin, String uid) async {
    try {
      await _users.collection("Besoins").add(besoin.toMap());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addShop(
    ShopModel shop,
  ) async {
    try {
      await _users.collection("Shops").add(shop.toMap());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addItem(
    Item item,
  ) async {
    try {
      _users.collection("Goods").add(item.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future<void> addPayment(
    Payment payment,
  ) async {
    try {
      await _users.collection("Payments").add(payment.toMap());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

// add KitchenElement to the kitchen
  Future<void> addKitchenElement(
    KitchenElement kitchenElement,
  ) async {
    try {
      await _users
          .collection(_collectionKitchenElements)
          .add(kitchenElement.toMap());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

// add KitchenItem to the kitchen
  Future<void> addKitchenItem(
      KitchenItem kitchenItem, String _collectionKitchenId) async {
    try {
      await _users
          .collection(_collectionKitchenElements)
          .doc(_collectionKitchenId)
          .collection(_collectionKitchenItems)
          .add(kitchenItem.toMap());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

// update ****/
// update KitchenElement
  Future<void> updateKitchenElement(
    KitchenElement kitchenElement,
    String _collectionKitchenId,
  ) async {
    try {
      await _users
          .collection(_collectionKitchenElements)
          .doc(_collectionKitchenId)
          .update(kitchenElement.toMap());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

// update KitchenItem
  Future<void> updateKitchenItem(
    KitchenItem kitchenItem,
    String _collectionKitchenId,
    String _collectionKitchenItemsId,
  ) async {
    try {
      await _users
          .collection(_collectionKitchenElements)
          .doc(_collectionKitchenId)
          .collection(_collectionKitchenItems)
          .doc(_collectionKitchenItemsId)
          .update(kitchenItem.toMap());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updateShop(
    ShopModel shopToUpdate,
  ) async {
    try {
      _users
          .collection("Shops")
          .doc(shopToUpdate.id)
          .update(shopToUpdate.toMap());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updateItem(
    Item itemToUpdate,
  ) async {
    try {
      _users
          .collection("Goods")
          .doc(
            itemToUpdate.id,
          )
          .update(itemToUpdate.toMap());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updatePayment(
    Payment itemToUpdate,
  ) async {
    try {
      _users
          .collection('Payments')
          .doc(itemToUpdate.id)
          .update(itemToUpdate.toMap());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updateBesoin(
    Besoin itemToUpdate,
    String uid,
  ) async {
    try {
      _users
          .collection("Besoins")
          .doc(itemToUpdate.id)
          .update(itemToUpdate.toMap());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

//delete
// delete KitchenElement
  Future<void> deleteKitchenElement(
    String _collectionKitchenId,
  ) async {
    try {
      await _users
          .collection(_collectionKitchenElements)
          .doc(_collectionKitchenId)
          .delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // delete KitchenItem
  Future<void> deleteKitchenItem(
    String _collectionKitchenId,
    String _collectionKitchenItemsId,
  ) async {
    try {
      await _users
          .collection(_collectionKitchenElements)
          .doc(_collectionKitchenId)
          .collection(_collectionKitchenItems)
          .doc(_collectionKitchenItemsId)
          .delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteShop(ShopModel shopToDelete) async {
    try {
      _users.collection('Shops').doc(shopToDelete.id).delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteItem(Item item) async {
    try {
      _users.collection('Goods').doc(item.id).delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deletePayment(Payment payment) async {
    try {
      _users.collection('Payments').doc(payment.id).delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteShopData(ShopData shopsData) async {
    for (var item in shopsData.allItems)
      try {
        _users.collection('Goods').doc(item.id).delete();
      } catch (e) {
        print(e);
        rethrow;
      }
  }
}
