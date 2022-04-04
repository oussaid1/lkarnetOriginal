import 'kitchen_item.dart';

class KitchenElementData {
  List<KitchenElement> kitchenElementList = [];
  List<KitchenItem> kitchenItemList = [];
  List<KitchenItem> fakekitchenElementItemsList =
      KitchenItem.fakeKitchenitems();
  //List<KitchenItem> kitchenElementItemsList = [];
  KitchenElementData(this.kitchenElementList, this.kitchenItemList) {
    // kitchenElementList = [];
    // kitchenItemList = [];
  }

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

// get a list of all unavaliable elements
  List<KitchenElement> get unavaliableKitchenElements {
    //List<KitchenElement> _kitchenElements = [];
//  List<KitchenItem> _kitchenItems = [];
    return kitchenElementList.where((element) => !element.isAvailable).toList();
  }

//   // get kitchen items for a single kitchen element object
// List<KitchenItem> getKitchenItems(KitchenElement kitchenElement){

// }
<<<<<<< HEAD
=======
>>>>>>> 55dc683 (kitchen element items crud)
=======
>>>>>>> 7cea0f9 (v 0.9.2)
}
