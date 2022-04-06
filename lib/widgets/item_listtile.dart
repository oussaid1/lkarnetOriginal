import 'package:flutter/material.dart';
import 'package:lkarnet/screens/add/add_kitchen_item.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:lkarnet/widgets/dialogs.dart';

import '../components.dart';
import '../models/item/item.dart';
import '../providers/operationsprovider/operations_provider.dart';
import '../providers/varproviders/var_providers.dart';
import '../screens/add/add_item.dart';
import 'price_curency_widget.dart';

class ItemTileWidget extends ConsumerWidget {
  const ItemTileWidget({
    Key? key,
    required this.item,
    this.onTap,
  }) : super(key: key);
  final VoidCallback? onTap;
  final Item item;

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddKitchenItem(
              item: item,
            ),
          ),
        );
      },
      // onLongPress: () {
      //   showMenu(
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(12),
      //     ),
      //     // color: AppConstants.greenOpacity,
      //     position: RelativeRect.fromLTRB(
      //       MediaQuery.of(context).size.width / 2,
      //       MediaQuery.of(context).size.height / 2,
      //       MediaQuery.of(context).size.width / 2,
      //       MediaQuery.of(context).size.height / 2,
      //     ),
      //     context: context,
      //     items: <PopupMenuEntry>[
      //       PopupMenuItem(
      //         onTap: () {
      //           Navigator.of(context).push(
      //             MaterialPageRoute(
      //               builder: (context) => AddScreen(
      //                 item: item,
      //               ),
      //             ),
      //           );
      //         },
      //         value: 1,
      //         child: Row(
      //           children: <Widget>[
      //             Icon(Icons.kitchen_rounded),
      //             Text("Add to Kitchen"),
      //           ],
      //         ),
      //       )
      //     ],
      //   );
      // },
      child: Slidable(
        //actionPane: SlidableDrawerActionPane(),
        //  actionExtentRatio: 0.25,

        startActionPane: ActionPane(
          // dismissible: DismissiblePane(onDismissed: () {}),
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              key: const Key('action-1'),
              backgroundColor: Colors.transparent,
              onPressed: (context) {
                ref.read(pickedDateTime.state).state = item.dateBought;
                ref.read(pickedShop.state).state = item.shopName;
                ref.watch(selectedQuantifierProvider.state).state =
                    item.quantifier;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddItem(
                      item: item,
                    ),
                  ),
                );
              },
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),

        endActionPane: ActionPane(
          //dismissible: DismissiblePane(onDismissed: () {}),
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
                key: const Key('action-12'),
                backgroundColor: Colors.transparent,
                label: 'Delete',
                onPressed: (context2) {
                  Dialogs.dialogSimple(context,
                      title: 'Are you sure !!?',
                      widgets: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 120,
                                child: ElevatedButton(
                                  child: Text('Cancel'),
                                  onPressed: () => Navigator.of(context).pop(),
                                  style: MThemeData.raisedButtonStyleCancel,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 120,
                                child: ElevatedButton(
                                  child: Text(
                                    'Ok',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  onPressed: () {
                                    ref
                                        .read(operationsProvider)
                                        .deleteItem(item);
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Item Deleted'),
                                      duration: Duration(seconds: 1),
                                      backgroundColor:
                                          AppConstants.greenOpacity,
                                    ));
                                  },
                                  style: MThemeData.raisedButtonStyleSave,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]);
                },
                icon: Icons.delete),
          ],
        ),

        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radius),
          ),
          color: AppConstants.whiteOpacity,
          child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color:
                            Color.fromARGB(255, 224, 2, 253).withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppConstants.radius),
                          bottomLeft: Radius.circular(AppConstants.radius),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${item.quantity}',
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '${item.quantifier}',
                            style: Theme.of(context).textTheme.subtitle2,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.itemName}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Row(
                          children: [
                            Text(
                              '${item.shopName}',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              '  ${item.dateBought.formatted()}',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(4.0),
                        child: PriceNumberZone(
                          price: item.itemPrix,
                          style: Theme.of(context).textTheme.headline4,
                          withDollarSign: true,
                        )),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
