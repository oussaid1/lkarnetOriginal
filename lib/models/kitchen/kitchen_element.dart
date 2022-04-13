import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

//import '../item/item.dart';

//enum KitchenItemStatus { full, half, empty }

class KitchenElementModel {
  String? id;
  String title;
  String? category = '';
  double? availability = 0;
  double? priority = 1;
// constr
  KitchenElementModel({
    this.id,
    required this.title,
    this.category,
    this.availability,
    this.priority,
  });

  // list of fake data
  static List<KitchenElementModel> get fakeKitchenElements {
    return [
      KitchenElementModel(
        title: 'Sugar',

        ///: 1,
        category: 'Sweet',
        availability: 1,
        priority: 1,
        //items: KitchenItem.fakeKitchenitems(),
      ),
      KitchenElementModel(
        title: 'Milk',
        // quantity: 1,
        category: 'Dairy',
        availability: 1,
        priority: 2,
        // items: KitchenItem.fakeKitchenitems(),
      ),
      KitchenElementModel(
        title: 'Bread',
        //  quantity: 5,
        category: 'Bakery',
        availability: 4,
        priority: 3,
        // items: KitchenItem.fakeKitchenitems(),
      ),
      KitchenElementModel(
        title: 'Eggs',

        ///   quantity: 1,
        category: 'Dairy',
        availability: 1,
        priority: 2,
        // items: KitchenItem.fakeKitchenitems(),
      ),
      KitchenElementModel(
        title: 'Coffee',
        //  quantity: 1,
        category: 'Beverage',
        availability: 1,
        priority: 1,
        //items: KitchenItem.fakeKitchenitems(),
      ),
      KitchenElementModel(
        title: 'Tea',
        //   quantity: 1,
        category: 'Beverage',
        availability: 1,
        priority: 1,
        // items: KitchenItem.fakeKitchenitems(),
      ),
      KitchenElementModel(
        title: 'Oil',
        //   quantity: 1,
        category: 'Tableware',
        availability: 1,
        priority: 1,
        // items: KitchenItem.fakeKitchenitems(),
      ),
      KitchenElementModel(
        title: 'Sugar',
        //   quantity: 1,
        category: 'Sweet',
        availability: 1,
        priority: 1,
        // items: KitchenItem.fakeKitchenitems(),
      ),
    ];
  }

  KitchenElementModel copyWith({
    String? id,
    String? title,
    double? quantity,
    String? category,
    double? availability,
    double? priority,
  }) {
    return KitchenElementModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      availability: availability ?? this.availability,
      priority: priority ?? this.priority,
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

  factory KitchenElementModel.fromDocumentSnapShot(DocumentSnapshot map) {
    return KitchenElementModel(
      id: map.id,
      title: map['title'],
      category: map['category'],
      availability: map['availability'].toDouble(),
      priority: map['priority'].toDouble(),
    );
  }

// from map to object
  factory KitchenElementModel.fromMap(Map<String, dynamic> map) {
    return KitchenElementModel(
      id: map['id'],
      title: map['title'],
      category: map['category'],
      availability: map['availability'],
      priority: map['priority'],
    );
  }
  String toJson() => json.encode(toMap());

  factory KitchenElementModel.fromJson(String source) =>
      KitchenElementModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'KitchenElement(id: $id, title: $title, category: $category, availability: $availability)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KitchenElementModel &&
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
