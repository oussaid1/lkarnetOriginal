import 'package:lkarnet/models/item/item.dart';

abstract class ItemDbInterface {
  void addItem(Item item);
  bool deleteItem(Item item);
  bool updateItem(Item item);
  Stream<List<Item>> getItems();
}
