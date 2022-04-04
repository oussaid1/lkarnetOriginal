import 'package:lkarnet/components.dart';
import 'package:lkarnet/models/item/item.dart';

import 'package:flutter/material.dart';
import 'package:lkarnet/providers/streamproviders/items_stream_provider.dart';

import '../../widgets/item_listtile.dart';
<<<<<<< HEAD

// filterPattern String from the search bar
final filterPatternProvider = StateProvider<String>((ref) {
  return '';
});
// filterType FilterType from the dropdown menu
final filterTypeProvider = StateProvider<FilterType>((ref) {
  return FilterType.all;
});
=======
>>>>>>> 336a080 (thanks Allah)

class ItemsList extends ConsumerStatefulWidget {
  final List<Item>? lista;
  ItemsList({
    Key? key,
    this.lista,
  }) : super(key: key);
  @override
<<<<<<< HEAD
  ConsumerState<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends ConsumerState<ItemsList> {
  final TextEditingController _filterController = TextEditingController();
  // String _filterPattern = '';
  //FilterType _filterType = FilterType.all;
  @override
  Widget build(BuildContext context) {
    //var _shopsDataList = ref.watch(shopsDataListProvider.state).state;
    var _list = ref.watch(itemsListNotifierProvider);

=======
  Widget build(BuildContext context, ref) {
    //var _shopsDataList = ref.watch(shopsDataListProvider.state).state;
    final _list = ref.watch(itemsListNotifierProvider);

>>>>>>> 336a080 (thanks Allah)
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
<<<<<<< HEAD
                child: Column(
                  children: [
                    // a text field and a dropdownbutton
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: _filterController,
                          onChanged: (value) {
                            ref.read(filterPatternProvider.state).state = value;
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear_all_rounded),
                              onPressed: () {
                                _filterController.clear();
                                ref.read(filterPatternProvider.state).state =
                                    '';
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppConstants.radius),
                            ),
                            labelText: 'Search',
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppConstants.radius),
                        color: AppConstants.whiteOpacity,
                      ),
                      width: 140,
                      height: 50,
                      child: DropdownButton<FilterType>(
                        value: FilterType.all,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (FilterType? newValue) {
                          ref.read(filterTypeProvider.state).state = newValue!;
                        },
                        items: FilterType.values.map((FilterType value) {
                          return DropdownMenuItem<FilterType>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
=======
>>>>>>> 336a080 (thanks Allah)
              ),
              BluredContainer(
                margin: EdgeInsets.only(top: 10, left: 4, right: 4, bottom: 8),
                child: ListView.builder(
                  shrinkWrap: true,
<<<<<<< HEAD
                  itemCount: _list.length, // _shopsDataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Item item = _list[index];
=======
                  itemCount: _list.itemsList.length, // _shopsDataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Item item = _list.itemsList[index];
>>>>>>> 336a080 (thanks Allah)
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
