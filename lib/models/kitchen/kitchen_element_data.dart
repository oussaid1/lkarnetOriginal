import 'kitchen_item.dart';

class KitchenElementData {
  List<KitchenElement> kitchenElementList = [];

  KitchenElementData(this.kitchenElementList) {
    // kitchenElementList = [];
    // kitchenItemList = [];
  }

<<<<<<< HEAD
  // list of kitchen elements with items
  List<KitchenElement> get kitchenElements {
    List<KitchenElement> _kitchenElements = [];
    List<KitchenItem> _kitchenItems = [];
    for (var i = 0; i < kitchenElementList.length; i++) {
      _kitchenItems = kitchenItemList
          .where(
              (element) => element.kitchenElementId == kitchenElementList[i].id)
          .toList();
      kitchenElementList[i].items = _kitchenItems;
      _kitchenElements.add(kitchenElementList[i]);
    }

    return kitchenElementList;
  }
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 7cea0f9 (v 0.9.2)

=======
>>>>>>> 1b32af8 (hamdollillah)
// get a list of all unavaliable elements
  List<KitchenElement> get unavaliableKitchenElements {
    //List<KitchenElement> _kitchenElements = [];
//  List<KitchenItem> _kitchenItems = [];
    return kitchenElementList.where((element) => !element.isAvailable).toList();
  }
<<<<<<< HEAD

//   // get kitchen items for a single kitchen element object
// List<KitchenItem> getKitchenItems(KitchenElement kitchenElement){

// }
<<<<<<< HEAD
=======
>>>>>>> 55dc683 (kitchen element items crud)
=======
>>>>>>> 7cea0f9 (v 0.9.2)
=======
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
>>>>>>> 1b32af8 (hamdollillah)
}
