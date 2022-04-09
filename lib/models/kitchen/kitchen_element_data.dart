import 'kitchen_item.dart';

class KitchenElementsData {
  List<KitchenElement> kitchenElementList = [];
  late String tag;
  KitchenElementsData(this.kitchenElementList);

  // get a list of distinct categories
  List<String> get distinctCategories {
    List<String> categories = [];
    for (var i = 0; i < kitchenElementList.length; i++) {
      categories.add(kitchenElementList[i].category!);
    }
    return categories.toSet().toList();
  }

// get a list of all unavaliable elements
  List<KitchenElement> get unavaliableKitchenElements {
    //List<KitchenElement> _kitchenElements = [];
//  List<KitchenItem> _kitchenItems = [];
    return kitchenElementList.where((element) => !element.isAvailable).toList();
  }
}

class SingleKitchenElementData {
  late KitchenElement _kitchenElement;
  late List<KitchenItem> _kitchenItems;
  SingleKitchenElementData(
      KitchenElement kitchenElement, List<KitchenItem> kitchenItems) {
    _kitchenElement = kitchenElement;
    _kitchenItems = kitchenItems;
  }
  List<KitchenItem> get _kitchenElementItems {
    return _kitchenItems
        .where((element) => element.kitchenElementId == _kitchenElement.id)
        .toList();
  }

  // return a perfect KitchenElement with all items
  KitchenElement get perfectKitchenElement {
    return _kitchenElement.copyWith(
      items: _kitchenElementItems,
    );
  }
}
