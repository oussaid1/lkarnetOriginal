import 'package:flutter/material.dart';
import '../components.dart';
import '../models/item/item.dart';
import '../providers/varproviders/var_providers.dart';
import '../screens/add/add_item.dart';
import 'add_to_kitchen_from_item.dart';
import 'price_curency_widget.dart';

class ItemTileWidget extends ConsumerWidget {
  const ItemTileWidget({
    Key? key,
    required this.item,
    this.onTap,
    this.animationController,
  }) : super(key: key);
  final VoidCallback? onTap;
  final ItemModel item;
  final AnimationController? animationController;

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
              onPressed: (context2) {},
              icon: Icons.delete),
        ],
      ),

      child: GestureDetector(
        onDoubleTap: () {
          showModalBottomSheet(
              transitionAnimationController: animationController,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              // backgroundColor: Colors.black,
              context: context,
              isScrollControlled: true,
              isDismissible: true,
              barrierColor: Colors.white.withOpacity(0),
              backgroundColor: AppConstants.whiteOpacity,
              builder: (contsext) => Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    // height: MediaQuery.of(context).size.height * 0.5,
                    child: GlassContainer(
                      child: AddToKitchenFromItem(item: item),
                    ),
                  ));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radius),
            side: BorderSide(
              color: AppConstants.whiteOpacity,
              width: 1, // AppConstants.borderWidth,
            ),
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
