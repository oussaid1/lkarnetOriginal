import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/screens/add/add_item.dart';
import 'package:lkarnet/widgets/dialogs.dart';
import 'package:flutter/material.dart';

import '../components.dart';
import '../providers/varproviders/var_providers.dart';
import '../settings/theme.dart';

class ItemsListWidget extends ConsumerWidget {
  final List<Item> items;
  const ItemsListWidget({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      margin: EdgeInsets.only(top: 8, left: 4, right: 4, bottom: 40),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          Item item = items[index];
          return Slidable(
            startActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                    icon: (Icons.edit),
                    label: 'Edit',
                    onPressed: (context) {
                      ref.read(pickedDateTime.state).state = item.dateBought;
                      ref.read(selectedQuantifierProvider.state).state =
                          item.quantifier;
                      ref.read(pickedShop.state).state = item.shopName;

                      Dialogs.botomPopUpDialog(context, AddItem(item: item));
                    })
              ],
            ),
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  icon: (Icons.delete),
                  onPressed: (context) {
                    Dialogs.dialogSimple(context,
                        title: 'Are you sure !!?',
                        widgets: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 120,
                                  child: TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () => Navigator.pop(context),
                                    style: MThemeData.textButtonStyleCancel,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 120,
                                  child: TextButton(
                                    child: Text(
                                      'Ok',
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                    onPressed: () {},
                                    // onPressed: (){} => context
                                    //     .read(operationsProvider)
                                    //     .deleteItem(item)
                                    //     .then((value) =>
                                    //         Navigator.of(context).pop()),
                                    style: MThemeData.textButtonStyleSave,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]);
                  },
                ),
              ],
            ),
            child: Container(
              margin: EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                //color: Theme.of(context).colorScheme.secondary,
              ),
              child: BluredContainer(
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 4, right: 4),
                  leading: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(999.0),
                      boxShadow: [],
                    ),
                    height: 45,
                    width: 45,
                    child: Icon(Icons.shopping_bag_rounded),
                  ),
                  title: Text(
                    item.itemName,
                  ),
                  trailing: Text(
                    '\$ ${item.itemPrix}',
                  ),
                  subtitle: Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          item.quantity.toString(),
                        ),
                        Text(
                          ' ${item.shopName.toString()}',
                        ),
                        Text(
                          item.formattedDate,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
