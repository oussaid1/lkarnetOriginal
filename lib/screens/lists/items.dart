import 'package:lkarnet/components.dart';
import 'package:lkarnet/models/item/item.dart';

import 'package:flutter/material.dart';
import 'package:lkarnet/providers/streamproviders/items_stream_provider.dart';

import '../../widgets/item_listtile.dart';

class ItemsList extends ConsumerWidget {
  final List<Item>? lista;
  ItemsList({
    Key? key,
    this.lista,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    //var _shopsDataList = ref.watch(shopsDataListProvider.state).state;
    final _list = ref.watch(itemsListNotifierProvider);

    return GlassMaterial(
      circleWidgets: [
        Positioned(
          width: 100,
          height: 100,
          left: 10,
          top: 120,
          child: AppAssets.pinkCircleWidget,
        ),
        Positioned(
          width: 180,
          height: 180,
          right: 80,
          top: 200,
          child: AppAssets.purpleCircleWidget,
        ),
        Positioned(
          width: 140,
          height: 140,
          left: 30,
          bottom: 80,
          child: AppAssets.blueCircleWidget,
        ),
      ],
      gradientColors: [
        Color.fromARGB(255, 134, 32, 230),
        Color.fromARGB(255, 224, 101, 101),
        Color.fromARGB(255, 224, 101, 101),
      ],
      centerWidget: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            // IconButton(
            //   icon: Icon(Icons.add_box_outlined),
            //   onPressed: () async {
            //     var logger = Logger();
            //     for (var item in items!) {
            //       logger.d(item.toMap());
            //     }
            //   },
            // ),
          ],
          leading: Icon(Icons.menu, color: Colors.black),
          title: Text(
            'All Items',
            style: Theme.of(context).textTheme.headline2,
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          excludeHeaderSemantics: true,
          toolbarHeight: 40,
          backgroundColor: AppConstants.whiteOpacity,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppConstants.radius),
              bottom: Radius.circular(AppConstants.radius),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: 400,
                height: 140,
                decoration: BoxDecoration(
                  color: AppConstants.whiteOpacity,
                ),
              ),
              BluredContainer(
                margin: EdgeInsets.only(top: 10, left: 4, right: 4, bottom: 8),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _list.itemsList.length, // _shopsDataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Item item = _list.itemsList[index];
                    return ItemTileWidget(
                      item: item,
                    );
                    //ShopData shopsData = _shopsDataList[index];
                    // return  ExpansionTile(
                    //   title: Text('${shopsData.shop.shopName}'),
                    //   trailing: Text('${shopsData.countItems}'),
                    //   leading: CircleAvatar(
                    //     child: const Icon(
                    //       Icons.account_circle,
                    //       size: 40,
                    //       color: Colors.grey,
                    //     ),
                    //     backgroundColor:
                    //         Theme.of(context).colorScheme.secondary,
                    //   ),
                    //   expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Container(
                    //       height: 300,
                    //       width: 400,
                    //       child: GoodsList(
                    //         lista: shopsData.allItems,
                    //       ),
                    //     ),
                    //   ],
                    // );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoodsList extends ConsumerWidget {
  final List<Item>? lista;
  GoodsList({Key? key, this.lista}) : super(key: key);

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
