import 'package:flutter/material.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:lkarnet/widgets/dialogs.dart';
import '../components.dart';
import '../models/kitchen/kitchen_item.dart';
import '../providers/operationsprovider/operations_provider.dart';
import '../providers/varproviders/var_providers.dart';
import '../screens/add/add_kitchen_item.dart';
import 'price_curency_widget.dart';

class KitchenItemTileWidget extends ConsumerWidget {
  const KitchenItemTileWidget({
    Key? key,
    required this.kitchenItem,
  }) : super(key: key);

  final KitchenItem kitchenItem;

  @override
  Widget build(BuildContext context, ref) {
    return Slidable(
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
              ref.read(pickedDateTime.state).state = kitchenItem.dateBought;
              ref.read(pickedShop.state).state = kitchenItem.shopName;
              ref.watch(selectedQuantifierProvider.state).state =
                  kitchenItem.quantifier;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddKitchenItem(
                    kitchenItem: kitchenItem,
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
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                onPressed: () => ref
                                    .read(operationsProvider)
                                    .deleteKitchenItem(kitchenItem)
                                    .then(
                                        (value) => Navigator.of(context).pop()),
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
                      color: Color.fromARGB(255, 224, 2, 253).withOpacity(0.2),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppConstants.radius),
                        bottomLeft: Radius.circular(AppConstants.radius),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${kitchenItem.quantity}',
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${kitchenItem.quantifier}',
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
                        '${kitchenItem.itemName}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Row(
                        children: [
                          Text(
                            '${kitchenItem.shopName}',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            '  ${kitchenItem.dateBought.formatted()}',
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
                        price: kitchenItem.itemPrice,
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
    );
  }

  // // build bottomsheet for add item
  // void mBottomSheet(
  //   BuildContext context, {
  //   AnimationController? controller
  //   // required Widget child,
  // }) {
  //   showModalBottomSheet(
  //       transitionAnimationController: controller,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(
  //           top: Radius.circular(25.0),
  //         ),
  //       ),
  //       // backgroundColor: Colors.black,
  //       context: context,
  //       isScrollControlled: true,
  //       isDismissible: true,
  //       builder: (_) {
  //         return Container(
  //           decoration: BoxDecoration(
  //             color: Color.fromARGB(255, 189, 110, 110),
  //             borderRadius: BorderRadius.vertical(
  //               top: Radius.circular(25.0),
  //             ),
  //           ),
  //           height: 160,
  //           child: Padding(
  //             padding: MediaQuery.of(context).viewInsets,
  //             child: (
  //               item: _localItem!,
  //               op: ref.read(operationsProvider),
  //             ),
  //           ),
  //         );
  //       });
  // }
}
