import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/kitchen/kitchen_item.dart';
import 'package:lkarnet/providers/authproviders/database_providers.dart';

// stream of KitchenElement list from Firebase
final kitchenElementsStream = StreamProvider<List<KitchenElement>>((ref) {
  final _db = ref.watch(databaseProvider);
  return _db.kitchenElementsStream();
});
// connvert stream to list
final kitchenElementsProvider = StateProvider<List<KitchenElement>>((ref) {
  final stream = ref.watch(kitchenElementsStream);
  return stream.maybeWhen(data: (items) => items, orElse: () => []);
});

final kitchenElementListNotifierProvider =
    ChangeNotifierProvider<KitchenElementListNotifier>((ref) {
  final _kitchenElements = ref.watch(kitchenElementsProvider.state).state;
  return KitchenElementListNotifier(_kitchenElements);
});

class KitchenElementListNotifier extends ChangeNotifier {
  KitchenElementListNotifier(this.kitchenElementList) {
    kitchenElementList.isEmpty
        ? kitchenElementList = fakekitchenElementList
        : kitchenElementList;
  }

  List<KitchenElement> kitchenElementList = [];
  List<KitchenElement> fakekitchenElementList =
      KitchenElement.fakeKitchenElements;

  // List<SocialMediaProfile> get kitchenElementList => kitchenElementList;

  // set kitchenElementList(List<SocialMediaProfile> value) {
  //   kitchenElementList = value;
  //   // state = kitchenElementList;
  //   notifyListeners();
  // }

  void addSocialProfil(KitchenElement value) {
    kitchenElementList.add(value);
    // state.add(value);
    notifyListeners();
  }

  void removeSocialProfil(int index) {
    kitchenElementList.removeAt(index);
    //state.remove(value);
    notifyListeners();
  }
}

///
/// stream for KitchenElementItems

final kitchenElementItemsStream = StreamProvider<List<KitchenItem>>((ref) {
  final _db = ref.watch(databaseProvider);
  return _db.kitchenItemsStream();
});
// connvert stream to list
final kitchenElementItemsProvider = StateProvider<List<KitchenItem>>((ref) {
  final stream = ref.watch(kitchenElementItemsStream);
  return stream.maybeWhen(data: (kitchenItem) => kitchenItem, orElse: () => []);
});

final kitchenElementItemsListNotifierProvider =
    ChangeNotifierProvider<KitchenElementItemsListNotifier>((ref) {
  final _kitchenElementsItems =
      ref.watch(kitchenElementItemsProvider.state).state;
  return KitchenElementItemsListNotifier(_kitchenElementsItems);
});

class KitchenElementItemsListNotifier extends ChangeNotifier {
  KitchenElementItemsListNotifier(this.kitchenElementItemsList) {
    kitchenElementItemsList.isEmpty
        ? kitchenElementItemsList = fakekitchenElementItemsList
        : kitchenElementItemsList;
  }

  List<KitchenItem> kitchenElementItemsList = [];
  List<KitchenItem> fakekitchenElementItemsList =
      KitchenItem.fakeKitchenitems();

  // List<SocialMediaProfile> get kitchenElementList => kitchenElementList;

  // set kitchenElementList(List<SocialMediaProfile> value) {
  //   kitchenElementList = value;
  //   // state = kitchenElementList;
  //   notifyListeners();
  // }

  void addSocialProfil(KitchenItem value) {
    kitchenElementItemsList.add(value);
    // state.add(value);
    notifyListeners();
  }

  void removeSocialProfil(int index) {
    kitchenElementItemsList.removeAt(index);
    //state.remove(value);
    notifyListeners();
  }
}
