import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lkarnet/components.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/models/shop/shops_data.dart';
import 'package:lkarnet/providers/operationsprovider/operations_provider.dart';
import 'package:lkarnet/screens/add/add_item.dart';
import 'package:lkarnet/settings/theme.dart';

import 'package:lkarnet/widgets/dialogs.dart';

class ItemsList extends ConsumerWidget {
  final List<Item>? lista;
  ItemsList({
    Key? key,
    this.lista,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var _shopsDataList = ref.watch(shopsDataListProvider.state).state;

    return Container(
      margin: EdgeInsets.only(top: 10, left: 4, right: 4, bottom: 8),
      child: ListView.builder(
        itemCount: _shopsDataList.length,
        itemBuilder: (BuildContext context, int index) {
          ShopsData shopsData = _shopsDataList[index];
          return new ExpansionTile(
            title: Text('${shopsData.shop.shopName}'),
            trailing: Text('${shopsData.countItems}'),
            leading: CircleAvatar(
              child: const Icon(
                Icons.account_circle,
                size: 40,
                color: Colors.grey,
              ),
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                width: 400,
                child: GoodsList(
                  lista: shopsData.allItems,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class GoodsList extends ConsumerWidget {
  final List<Item>? lista;
  GoodsList({
    Key? key,
    this.lista,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 4, right: 4, bottom: 8),
      child: ListView.builder(
        itemCount: lista!.length,
        itemBuilder: (BuildContext context, int index) {
          Item item = lista![index];
          return ItemTileWidget(item: item);
        },
      ),
    );
  }
}

class ItemTileWidget extends ConsumerWidget {
  const ItemTileWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context, ref) {
    return Slidable(
      //actionPane: SlidableDrawerActionPane(),
      //  actionExtentRatio: 0.25,

      startActionPane: ActionPane(
        dismissible: DismissiblePane(onDismissed: () {}),
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            key: const Key('action-1'),
            backgroundColor: Colors.transparent,
            onPressed: (context) {
              Dialogs.botomPopUpDialog(
                context,
                AddItem(
                  item: item,
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
              key: const Key('action-2'),
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
                              child: TextButton(
                                child: Text('Cancel'),
                                onPressed: () => Navigator.of(context).pop(),
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
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                onPressed: () => ref
                                    .read(operationsProvider)
                                    .deleteItem(item)
                                    .then(
                                        (value) => Navigator.of(context).pop()),
                                style: MThemeData.textButtonStyleSave,
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
                      Text(
                        '${item.dateBought.formatted()}',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      '${item.itemPrix.toPrecision()}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Text(
                    'DH',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
