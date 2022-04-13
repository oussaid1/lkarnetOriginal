import 'kitchen_element.dart';
import 'kitchen_item.dart';

class KitchenElementsData {
  List<KitchenElement> kitchenElementList = [];
  late List<KitchenItem> kitchenItems;
  KitchenElementsData(
      {required this.kitchenElementList, required this.kitchenItems});

  // get a list of distinct categories
  List<String> get distinctCategories {
    List<String> categories = [];
    for (var i = 0; i < kitchenElementList.length; i++) {
      categories.add(kitchenElementList[i].category!);
    }
    return categories.toSet().toList();
  }

// get a list of all unavaliable elements
  List<KitchenElement> get unavaliableElements {
    //List<KitchenElement> _kitchenElements = [];
//  List<KitchenItem> _kitchenItems = [];
    return kitchenElementList.where((element) => !element.isAvailable).toList();
  }

// get a list of all avaliable elements
  List<SingleKitchenElementData> get singleKitchenElementData {
    List<SingleKitchenElementData> _singleKitchenElements = [];
    for (var i = 0; i < kitchenElementList.length; i++) {
      _singleKitchenElements.add(
        SingleKitchenElementData(
          kitchenElement: kitchenElementList[i],
          kitchenItems: kitchenItems,
        ),
      );
    }
    return _singleKitchenElements;
  }

  // get a list of tagged elements
  List<SingleKitchenElementData> get taggedsingleKitchenElementData {
    List<SingleKitchenElementData> _kitchenElements = [];
    for (var i = 0; i < distinctCategories.length; i++) {
      _kitchenElements.add(
        SingleKitchenElementData(
            kitchenElement: kitchenElementList.firstWhere(
              (element) => element.category == distinctCategories[i],
            ),
            kitchenItems: kitchenItems,
            tagg: distinctCategories[i]),
      );
    }
    return _kitchenElements;
  }
}

class SingleKitchenElementData {
  late String tag;
  late KitchenElement kitchenElement;
  late List<KitchenItem> kitchenItems;
  SingleKitchenElementData({
    String? tagg,
    required this.kitchenElement,
    required this.kitchenItems,
  }) {
    tag = tagg ?? kitchenElement.category ?? 'No Category';
  }
  List<KitchenItem> get _kitchenElementItems {
    return kitchenItems
        .where((element) => element.kitchenElementId == kitchenElement.id)
        .toList();
  }

  // return a perfect KitchenElement with all items
  KitchenElement get perfectKitchenElement {
    return kitchenElement.copyWith(
      items: _kitchenElementItems,
    );
  }
}

class ScaresElements {
  List<SingleKitchenElementData> _kitchenElements = [];
  ScaresElements(this._kitchenElements);
  // get a lis of expired elements
  List<SingleKitchenElementData> get expiredElements {
    return _kitchenElements
        .where((element) => !element.kitchenElement.isAvailable)
        .toList();
  }

  // get the total price of expired elements
  double get expiredElementsPrice {
    return expiredElements.fold(
      0,
      (previousValue, element) =>
          previousValue + element.kitchenElement.totalPrice,
    );
  }
}

class PerfectKitchenelement {
  late KitchenElement kitchenElement;
  late List<KitchenItem> _kitchenItems;
  PerfectKitchenelement(this.kitchenElement, List<KitchenItem> kitchenItems) {
    _kitchenItems = kitchenItems
        .where((element) => element.kitchenElementId == kitchenElement.id)
        .toList();
  }
  // get a perfect kitchen element with all items
  KitchenElement get perfectKitchenElement {
    return kitchenElement.copyWith(
      items: _kitchenItems,
    );
  }
}
