import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lkarnet/const/constents.dart';
import 'package:lkarnet/models/shop/shops_data.dart';
import 'package:lkarnet/providers/operationsprovider/operations_provider.dart';
import 'package:lkarnet/screens/add/add_shop.dart';
import 'package:lkarnet/widgets/dialogs.dart';
import 'package:lkarnet/widgets/glasswidget.dart';

import '../../settings/theme.dart';

class ShopsList extends ConsumerWidget {
  ShopsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    //  final lista = ref.watch(shopsProvider.state).state;
    var _shopsDataList = ref.watch(shopsDataListProvider.state).state;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          BluredContainer(
            margin: EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 8),
            child: ListView.builder(
              itemCount: _shopsDataList.length,
              itemBuilder: (BuildContext context, int index) {
                ShopData shopsData = _shopsDataList[index];
                return Slidable(
                    startActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.mode_edit,
                              size: 30,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            color: Colors.transparent,
                            onPressed: () {
                              Dialogs.botomPopUpDialog(
                                  context, AddShop(shop: shopsData.shop));
                            }),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.delete_forever,
                            size: 30,
                            color: Theme.of(context).errorColor,
                          ),
                          color: Colors.transparent,
                          onPressed: () {
                            Dialogs.dialogSimple(context,
                                title: 'Are you sure !!?',
                                widgets: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 120,
                                          child: TextButton(
                                            child: Text('Cancel'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            style: MThemeData
                                                .textButtonStyleCancel,
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
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                            ),
                                            onPressed: () => ref
                                                .read(operationsProvider)
                                                .deleteShopData(shopsData)
                                                .then((value) =>
                                                    Navigator.of(context)
                                                        .pop()),
                                            style:
                                                MThemeData.textButtonStyleSave,
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
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: BluredContainer(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.only(left: 8, right: 8),
                            leading: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppConstants.whiteOpacity,
                              ),
                              child: Icon(Icons.person),
                            ),
                            title: Text(
                              ' ${shopsData.shop.shopName}',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${(shopsData.shop.limit)}',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                Text(
                                  'limit',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
