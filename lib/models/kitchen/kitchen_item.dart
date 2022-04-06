import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lkarnet/components.dart';

import '../item/item.dart';

//import '../item/item.dart';

enum KitchenItemStatus { full, half, empty }

class KitchenElement {
  String? id;
  String title;
  String? category = '';
  double? availability = 0;
  double? priority = 1;
// constr
  KitchenElement({
    this.id,
    required this.title,
    this.category,
    this.availability,
    this.priority,
    required this.items,
  });
  List<KitchenItem> items = [];

// get isNotAvailable
  bool get isAvailable {
    return availability != 0;
  }

// get the number of times the element is bought
  int get timesBought {
    if (items.isEmpty)
      return 0;
    else
      return items.length;
  }

// get the date of the last item
  String get lastTimeBought {
    return items.isEmpty ? 'Not bought yet' : items.first.dateBought.ddmmyyyy();
  }

// get time expired of the last item
  String get timeExpired {
    return items.isEmpty || items.first.dateExpired == null
        ? 'Still in stock'
        : items.first.dateExpired!.ddmmyyyy();
  }

// get last item was bought
  KitchenItem? get lastItemBought {
    // if items is empty return null
    if (items.isEmpty) return null;
    // get last item
    final lastItem = items.last;
    // if last item is not bought return null
    // return last item
    return lastItem;
  }

  // list of fake data
  static List<KitchenElement> get fakeKitchenElements {
    return [
      KitchenElement(
          title: 'Sugar',

          ///: 1,
          category: 'Sweet',
          availability: 1,
          priority: 1,
          items: KitchenItem.fakeKitchenitems()),
      KitchenElement(
        title: 'Milk',
        // quantity: 1,
        category: 'Dairy',
        availability: 1,
        priority: 2,
        items: KitchenItem.fakeKitchenitems(),
      ),
      KitchenElement(
        title: 'Bread',
        //  quantity: 5,
        category: 'Bakery',
        availability: 4,
        priority: 3,
        items: KitchenItem.fakeKitchenitems(),
      ),
      KitchenElement(
        title: 'Eggs',

        ///   quantity: 1,
        category: 'Dairy',
        availability: 1,
        priority: 2,
        items: KitchenItem.fakeKitchenitems(),
      ),
      KitchenElement(
        title: 'Coffee',
        //  quantity: 1,
        category: 'Beverage',
        availability: 1,
        priority: 1,
        items: KitchenItem.fakeKitchenitems(),
      ),
      KitchenElement(
        title: 'Tea',
        //   quantity: 1,
        category: 'Beverage',
        availability: 1,
        priority: 1,
        items: KitchenItem.fakeKitchenitems(),
      ),
      KitchenElement(
        title: 'Oil',
        //   quantity: 1,
        category: 'Tableware',
        availability: 1,
        priority: 1,
        items: KitchenItem.fakeKitchenitems(),
      ),
      KitchenElement(
        title: 'Sugar',
        //   quantity: 1,
        category: 'Sweet',
        availability: 1,
        priority: 1,
        items: KitchenItem.fakeKitchenitems(),
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
      category: category ?? this.category,
      availability: availability ?? this.availability,
      items: items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'availability': availability,
      'priority': priority,
    };
  }

  factory KitchenElement.fromDocumentSnapShot(DocumentSnapshot map) {
    return KitchenElement(
      id: map.id,
      title: map['title'],
      category: map['category'],
      availability: map['availability'].toDouble(),
      priority: map['priority'].toDouble(),
      items: [],
    );
  }

// from map to object
  factory KitchenElement.fromMap(Map<String, dynamic> map) {
    return KitchenElement(
      id: map['id'],
      title: map['title'],
      category: map['category'],
      availability: map['availability'],
      priority: map['priority'],
      items: [],
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
  late String kitchenElementId;
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
    this.count = 1,
    required this.kitchenElementId,
    required this.dateBought,
    required this.dateExpired,
  });
  DateTime dateBought = DateTime.now();
  DateTime? dateExpired; // double get itemPrix => itemPrice * quantity;

  KitchenItem copyWith({
    String? id,
    String? besoinTitle,
    String? shopName,
    String? itemName,
    String? quantifier,
    double? quantity,
    double? itemPrice,
    int? count,
    DateTime? dateBought,
    DateTime? dateExpired,
    required String kitchenElementId,
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
        dateBought: dateBought ?? this.dateBought,
        dateExpired: dateExpired ?? this.dateExpired,
        kitchenElementId: kitchenElementId);
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
      'kitchenElementId': kitchenElementId,
    };
  }

  KitchenItem.fromItem(Item item, KitchenElement kitchenElement) {
    this.besoinTitle = item.itemName;
    this.shopName = item.shopName;
    this.itemName = item.itemName;
    this.quantifier = item.quantifier;
    this.quantity = item.quantity;
    this.itemPrice = item.itemPrice;
    this.count = item.count;
    this.dateBought = item.dateBought;
    this.dateExpired = null;
    this.kitchenElementId = kitchenElement.id!;
  }
  KitchenItem.fromDocumentSnapShot(QueryDocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    besoinTitle = documentSnapshot['besoinTitle'];
    itemName = documentSnapshot['itemName'].trim();
    quantifier = documentSnapshot['quantifier'];
    quantity = documentSnapshot['quantity'].toDouble();
    itemPrice = (documentSnapshot['itemPrice']).toDouble() ?? 0;
    shopName = documentSnapshot['shopName'] ?? '';
    Timestamp f1 = documentSnapshot['dateBought'];
    dateBought = f1.toDate();
    // f = documentSnapshot['dateExpired'];
    dateExpired = documentSnapshot['dateExpired'];
    kitchenElementId = documentSnapshot['kitchenElementId'] ?? '';
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
    print('dateExpired : $toMMYY');
    print('kitchenElementId : $kitchenElementId');
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
      dateBought: map['dateBought'],
      dateExpired: map['dateExpired'],
      kitchenElementId: map['kitchenElementId'],
    );
  }
  String toJson() => json.encode(toMap());

  factory KitchenItem.fromJson(String source) =>
      KitchenItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'KitchenItem(id: $id, besoinTitle: $besoinTitle,  shopName: $shopName, itemName: $itemName, quantifier: $quantifier, quantity: $quantity, itemPrice: $itemPrice, count: $count, dateBought: $dateBought, dateExpired: $dateExpired, kitchenElementId: $kitchenElementId)';
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
        other.count == count &&
        other.dateBought == dateBought &&
        other.dateExpired == dateExpired &&
        other.kitchenElementId == kitchenElementId;
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
        count.hashCode ^
        dateBought.hashCode ^
        dateExpired.hashCode ^
        kitchenElementId.hashCode;
  }

  // list of fake data
  static List<KitchenItem> fakeKitchenitems() {
    return [
      KitchenItem(
        besoinTitle: 'test',
        shopName: 'مومو',
        itemName: 'test',
        quantifier: 'واحدة',
        quantity: 1,
        itemPrice: 1,
        count: 1,
        dateBought: DateTime.now(),
        dateExpired: DateTime.now(),
        kitchenElementId: 'VtRluxV8Sy7tQaa6yoNO',
      ),
      KitchenItem(
        besoinTitle: 'test',
        shopName: 'مومو',
        itemName: 'test',
        quantifier: 'واحدة',
        quantity: 1,
        itemPrice: 1,
        count: 1,
        dateBought: DateTime.now(),
        dateExpired: DateTime.now(),
        kitchenElementId: 'VtRluxV8Sy7tQaa6yoNO',
      ),
      KitchenItem(
        besoinTitle: 'test',
        shopName: 'مومو',
        itemName: 'test',
        quantifier: 'test',
        quantity: 1,
        itemPrice: 1,
        count: 1,
        dateBought: DateTime.now(),
        dateExpired: DateTime.now(),
        kitchenElementId: 'VtRluxV8Sy7tQaa6yoNO',
      ),
      KitchenItem(
        besoinTitle: 'test',
        shopName: 'مومو',
        itemName: 'test',
        quantifier: 'واحدة',
        quantity: 1,
        itemPrice: 1,
        count: 1,
        dateBought: DateTime.now(),
        dateExpired: DateTime.now(),
        kitchenElementId: 'I7ebCrvYuGKPL79sUhFl',
      ),
      KitchenItem(
        besoinTitle: 'test',
        shopName: 'مومو',
        itemName: 'test',
        quantifier: 'واحدة',
        quantity: 1,
        itemPrice: 1,
        count: 1,
        dateBought: DateTime.now(),
        dateExpired: DateTime.now(),
        kitchenElementId: 'I7ebCrvYuGKPL79sUhFl',
      ),
    ];
  }
}
