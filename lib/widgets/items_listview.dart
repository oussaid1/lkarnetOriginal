import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/screens/add/add_item.dart';
import 'package:lkarnet/widgets/dialogs.dart';

class ItemsListWidget extends StatelessWidget {
  final List<Item> items;
  const ItemsListWidget({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                SlidableAction(onPressed: (context) {
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
                                    style: TextButton.styleFrom(
                                      textStyle:
                                          Theme.of(context).textTheme.headline3,
                                      minimumSize: Size(88, 36),
                                      elevation: 0,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                      ),
                                    ),
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
                                    style: TextButton.styleFrom(
                                      textStyle:
                                          Theme.of(context).textTheme.headline3,
                                      minimumSize: Size(88, 36),
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      elevation: 0,
                                      onSurface:
                                          Theme.of(context).colorScheme.primary,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                      ),
                                    ),
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
            child: Card(
              elevation: 6,
              margin: EdgeInsets.all(4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
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
                  item.itemName!,
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
          );
        },
      ),
    );
  }
}
