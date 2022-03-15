import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lkarnet/components.dart';

//import '../item/item.dart';

enum KitchenItemStatus { full, half, empty }

class KitchenElement {
  String? id;
  String? title;
  //double? quantity;
  String? category;
  double? availability = 0;
  int? priority = 1;
// constr
  KitchenElement({
    this.id,
    this.title,
//this.quantity,
    this.category,
    this.availability,
    this.priority,
  });
  // List<Item> items = [];
  // double get totalPrice {
  //   return 0;
  // }

  // list of fake data
  static List<KitchenElement> get fakeKitchenItems {
    return [
      KitchenElement(
        title: 'Sugar',

        ///: 1,
        category: 'Sweet',
        availability: 1,
        priority: 1,
      ),
      KitchenElement(
        title: 'Milk',
        // quantity: 1,
        category: 'Dairy',
        availability: 1,
        priority: 2,
      ),
      KitchenElement(
        title: 'Bread',
        //  quantity: 5,
        category: 'Bakery',
        availability: 4,
        priority: 3,
      ),
      KitchenElement(
        title: 'Eggs',

        ///   quantity: 1,
        category: 'Dairy',
        availability: 1,
        priority: 2,
      ),
      KitchenElement(
        title: 'Coffee',
        //  quantity: 1,
        category: 'Beverage',
        availability: 1,
        priority: 1,
      ),
      KitchenElement(
        title: 'Tea',
        //   quantity: 1,
        category: 'Beverage',
        availability: 1,
        priority: 1,
      ),
      KitchenElement(
        title: 'Oil',
        //   quantity: 1,
        category: 'Tableware',
        availability: 1,
        priority: 1,
      ),
      KitchenElement(
        title: 'Sugar',
        //   quantity: 1,
        category: 'Sweet',
        availability: 1,
        priority: 1,
      ),
    ];
  }

  KitchenElement copyWith({
    String? id,
    String? title,
    double? quantity,
    String? category,
    double? availability,
  }) {
    return KitchenElement(
      id: id ?? this.id,
      title: title ?? this.title,
      //   quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      availability: availability ?? this.availability,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      // 'quantity': quantity,
      'category': category,
      'availability': availability,
    };
  }

  factory KitchenElement.fromDocumentSnapShot(DocumentSnapshot map) {
    return KitchenElement(
      id: map['id'],
      title: map['title'],
      //  quantity: map['quantity'],
      category: map['category'],
      availability: map['availability'],
    );
  }

// from map to object
  factory KitchenElement.fromMap(Map<String, dynamic> map) {
    return KitchenElement(
      id: map['id'],
      title: map['title'],
      //   quantity: map['quantity'],
      category: map['category'],
      availability: map['availability'],
    );
  }
  String toJson() => json.encode(toMap());

  factory KitchenElement.fromJson(String source) =>
      KitchenElement.fromMap(json.decode(source));

  @override
  String toString() {
    return 'KitchenElement(id: $id, title: $title, category: $category, availability: $availability)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KitchenElement &&
        other.id == id &&
        other.title == title &&
        other.category == category &&
        other.availability == availability;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        category.hashCode ^
        availability.hashCode;
  }
}

class KitchenItem {
  String? id;
  String? besoinTitle;
  String? shopName;
  String? itemName;
  String? quantifier;
  double quantity = 1;
  double itemPrice = 0;
  int count = 1;
  KitchenItem({
    this.id,
    this.besoinTitle,
    required this.shopName,
    required this.itemName,
    this.quantifier,
    required this.quantity,
    required this.itemPrice,
    required this.count,
  });
  DateTime dateBought = DateTime.now();
  DateTime dateExpired =
      DateTime.now(); // double get itemPrix => itemPrice * quantity;

  KitchenItem copyWith({
    String? id,
    String? besoinTitle,
    String? shopName,
    String? itemName,
    String? quantifier,
    double? quantity,
    double? itemPrice,
    int? count,
  }) {
    return KitchenItem(
      id: id ?? this.id,
      besoinTitle: besoinTitle ?? this.besoinTitle,
      shopName: shopName ?? this.shopName,
      itemName: itemName ?? this.itemName,
      quantifier: quantifier ?? this.quantifier,
      quantity: quantity ?? this.quantity,
      itemPrice: itemPrice ?? this.itemPrice,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'besoinTitle': besoinTitle,
      'shopName': shopName,
      'itemName': itemName,
      'quantifier': quantifier,
      'quantity': quantity,
      'itemPrice': itemPrice,
      'count': count,
      'dateBought': dateBought,
      'dateExpired': dateExpired,
    };
  }

  KitchenItem.fromDocumentSnapShot(QueryDocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    besoinTitle = documentSnapshot['besoinTitle'];
    itemName = documentSnapshot['itemName'].trim();
    quantifier = documentSnapshot['quantifier'];
    quantity = documentSnapshot['quantity'].toDouble();
    itemPrice = (documentSnapshot['itemPrice']).toDouble() ?? 0;
    shopName = documentSnapshot['shopName'] ?? '';
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

// from map
  factory KitchenItem.fromMap(Map<String, dynamic> map) {
    return KitchenItem(
      id: map['id'],
      besoinTitle: map['besoinTitle'],
      shopName: map['shopName'],
      itemName: map['itemName'],
      quantifier: map['quantifier'],
      quantity: map['quantity'],
      itemPrice: map['itemPrice'],
      count: map['count'],
    );
  }
  String toJson() => json.encode(toMap());

  factory KitchenItem.fromJson(String source) =>
      KitchenItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'KitchenItem(id: $id, besoinTitle: $besoinTitle, shopName: $shopName, itemName: $itemName, quantifier: $quantifier, quantity: $quantity, itemPrice: $itemPrice, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KitchenItem &&
        other.id == id &&
        other.besoinTitle == besoinTitle &&
        other.shopName == shopName &&
        other.itemName == itemName &&
        other.quantifier == quantifier &&
        other.quantity == quantity &&
        other.itemPrice == itemPrice &&
        other.count == count;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        besoinTitle.hashCode ^
        shopName.hashCode ^
        itemName.hashCode ^
        quantifier.hashCode ^
        quantity.hashCode ^
        itemPrice.hashCode ^
        count.hashCode;
  }
}
