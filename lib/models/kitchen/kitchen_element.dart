import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lkarnet/components.dart';

import 'kitchen_item.dart';

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
  List<KitchenItem> get sortedItems {
    items.sort((a, b) {
      if (a.dateExpired != null && b.dateExpired != null) {
        return a.dateExpired!.compareTo(b.dateExpired!);
      }
      return 0; //a.dateBought.compareTo(b.dateBought);
    });
    return items;
  }

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

// get the total price of all items
  double get totalPrice {
    return items.isEmpty
        ? 0
        : items.map((e) => e.itemPrice).reduce((a, b) => a + b);
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
    double? priority,
    List<KitchenItem>? items,
  }) {
    return KitchenElement(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      availability: availability ?? this.availability,
      priority: priority ?? this.priority,
      items: items ?? this.items,
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
