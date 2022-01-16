import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' as df;

class Item {
  String? id;
  String? besoinTitle;
  String? shopName;
  String? itemName;
  String? quantifier;
  double? quantity;
  double itemPrice = 0;
  int count = 1;
  DateTime dateBought = DateTime.now();

  double get itemPrix => itemPrice * count;

  static List<Item> fakeItems = [
    Item(
        besoinTitle: 'Lhanot',
        dateBought: DateTime.now(),
        itemName: 'Milk',
        itemPrice: 230,
        quantifier: 'kilo',
        quantity: 2,
        shopName: 'Momo'),
    Item(
        besoinTitle: 'Vegies',
        dateBought: DateTime.now(),
        itemName: 'Tomates',
        itemPrice: 450,
        quantifier: 'kilo',
        quantity: 2,
        shopName: 'Momo'),
    Item(
        besoinTitle: 'Fruits',
        dateBought: DateTime.now(),
        itemName: 'Apples',
        itemPrice: 230,
        quantifier: 'kilo',
        quantity: 2,
        shopName: 'Momo'),
  ];
  Item(
      {this.id,
      this.itemName,
      this.besoinTitle,
      this.quantifier,
      this.quantity,
      this.itemPrice = 0,
      this.shopName,
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
    final df.DateFormat _formatter = df.DateFormat('dd-MM-yy');
    return _formatter.format(dateBought).toString();
  }

  Item.fromDocumentSnapshot(QueryDocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    besoinTitle = documentSnapshot['besoinTitle'];
    itemName = documentSnapshot['itemName'];
    quantifier = documentSnapshot['quantifier'];
    quantity = documentSnapshot['quantity'].toDouble();
    itemPrice = (documentSnapshot['itemPrice']).toDouble() ?? 0;
    shopName = documentSnapshot['shopName'];
    Timestamp f = documentSnapshot['dateBought'];
    dateBought = f.toDate();
  }
  String get toYY {
    final df.DateFormat _formatter = df.DateFormat('yy');
    return _formatter.format(dateBought);
  }

  String get toMMYY {
    final df.DateFormat _formatter = df.DateFormat('MM-yy');
    return _formatter.format(dateBought);
  }

  String get toDDMMYY {
    final df.DateFormat _formatter = df.DateFormat('dd-MM-yy');
    return _formatter.format(dateBought);
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
