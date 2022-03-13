import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lkarnet/components.dart';

//import '../item/item.dart';

enum KitchenItemStatus { full, half, empty }

class KitchenElement {
  String? id;
  String? title;
  double? quantity;
  String? category;
  double? availability = 0;
// constr
  KitchenElement({
    this.id,
    this.title,
    this.quantity,
    this.category,
    this.availability,
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
        quantity: 1,
        category: 'Sweet',
        availability: 1,
      ),
      KitchenElement(
        title: 'Table Oil',
        quantity: 1,
        category: 'Oil',
        availability: 1,
      ),
      KitchenElement(
        title: 'Olive Oil',
        quantity: 1,
        category: 'Oil',
        availability: 1,
      ),
      KitchenElement(
        title: 'cummin',
        quantity: 1,
        category: 'Spices ',
        availability: 1,
      ),
      KitchenElement(
        title: 'Salt',
        quantity: 1,
        category: 'Spices',
        availability: 1,
      ),
      KitchenElement(
        title: 'Ginger',
        quantity: 1,
        category: 'Spices',
        availability: 1,
      ),
      KitchenElement(
        title: 'Green tea',
        quantity: 1,
        category: 'Tea',
        availability: 3,
      ),
      KitchenElement(
        title: 'Cake',
        quantity: 1,
        category: 'Dessert',
        availability: 1,
      ),
      KitchenElement(
        title: 'Cake',
        quantity: 1,
        category: 'Dessert',
        availability: 3,
      ),
      KitchenElement(
        title: 'Cake',
        quantity: 4,
        category: 'Dessert',
        availability: 4,
      ),
      KitchenElement(
        title: 'Cake',
        quantity: 2,
        category: 'Dessert',
        availability: 2,
      ),
      KitchenElement(
        title: 'Cake',
        quantity: 5,
        category: 'Dessert',
        availability: 5,
      ),
      KitchenElement(
        title: 'Cake',
        quantity: 3,
        category: 'Dessert',
        availability: 3,
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
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      availability: availability ?? this.availability,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'quantity': quantity,
      'category': category,
      'availability': availability,
    };
  }

  factory KitchenElement.fromDocumentSnapShot(DocumentSnapshot map) {
    return KitchenElement(
      id: map['id'],
      title: map['title'],
      quantity: map['quantity'],
      category: map['category'],
      availability: map['availability'],
    );
  }

// from map to object
  factory KitchenElement.fromMap(Map<String, dynamic> map) {
    return KitchenElement(
      id: map['id'],
      title: map['title'],
      quantity: map['quantity'],
      category: map['category'],
      availability: map['availability'],
    );
  }
  String toJson() => json.encode(toMap());

  factory KitchenElement.fromJson(String source) =>
      KitchenElement.fromMap(json.decode(source));

  @override
  String toString() {
    return 'KitchenElement(id: $id, title: $title, quantity: $quantity, category: $category, availability: $availability)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KitchenElement &&
        other.id == id &&
        other.title == title &&
        other.quantity == quantity &&
        other.category == category &&
        other.availability == availability;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        quantity.hashCode ^
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
