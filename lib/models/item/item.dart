import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lkarnet/components.dart';

class Item {
  // a zero argument constructor
  // Item();
  String? id;
  String? besoinTitle;
  late String shopName;
  late String itemName;
  String? quantifier;
  double quantity = 1;
  double itemPrice = 0;
  int count = 1;
  DateTime dateBought = DateTime.now();

  double get itemPrix => itemPrice * quantity;

  Item(
      {this.id,
      required this.itemName,
      this.besoinTitle,
      this.quantifier,
      required this.quantity,
      this.itemPrice = 0,
      required this.shopName,
      required this.dateBought,
      count = 1}) {
    if (quantifier!.trim().isEmpty) {
      quantifier = 'piece';
    }
  }
  Map<String, dynamic> toMap() {
    return {
      'itemName': itemName,
      'quantifier': quantifier,
      'besoinTitle': besoinTitle,
      'quantity': quantity,
      'itemPrice': itemPrice,
      'shopName': shopName,
      'dateBought': dateBought,
      'count': count,
    };
  }

  Map<String, dynamic> toMapForArch() {
    return {
      // 'id': id,
      'itemName': itemName,
      'quantifier': quantifier,
      'besoinTitle': besoinTitle,
      'quantity': quantity,
      'itemPrice': itemPrice,
      'shopName': shopName,
      'dateBought': dateBought,
      'count': count,
    };
  }

  String get formattedDate {
    return dateBought.formatted();
  }

  Item.fromDocumentSnapshot(QueryDocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    besoinTitle = documentSnapshot['besoinTitle'];
    itemName = documentSnapshot['itemName'].trim();
    quantifier = documentSnapshot['quantifier'];
    quantity = documentSnapshot['quantity'].toDouble();
    itemPrice = (documentSnapshot['itemPrice']).toDouble() ?? 0;
    shopName = documentSnapshot['shopName'];
    Timestamp f = documentSnapshot['dateBought'];
    dateBought = f.toDate();
  }
  String get toYY {
    return dateBought.yyyy();
  }

  String get toMMYY {
    return dateBought.mmyyyy();
  }

  String get toDDMMYY {
    return dateBought.ddmmyyyy();
  }

  void toPrint() {
    print('-------------------------------');
    print('name : $itemName');
    print('quantifier : $quantifier');
    print('quantity : $quantity');
    print('itemPrice : $itemPrice');
    print('besoinTitle : $besoinTitle');
    print('shopName : $shopName');
    print('dateBought : $toMMYY');
    print('-------------------------------');
  }
}
