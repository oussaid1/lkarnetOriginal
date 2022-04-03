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
}
