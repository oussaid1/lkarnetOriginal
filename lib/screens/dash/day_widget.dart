import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/shop/shops_data.dart';
import 'package:lkarnet/models/statistics/tagged.dart';
import 'package:lkarnet/widgets/glasswidget.dart';
import 'package:lkarnet/widgets/items_listview.dart';

final mlistIndex = StateProvider<int>((ref) {
  return 0;
});

class DailyDash extends ConsumerWidget {
  const DailyDash({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var _listOfTagged;
    var _currentIndex = ref.watch(mlistIndex.state).state;

    final _tagged = _listOfTagged[_currentIndex];

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back_ios_rounded),
                    onPressed: () {
                      if (_currentIndex > 0) ref.read(mlistIndex.state).state--;
                    }),
                Row(
                  children: [
                    Text(
                      'Day: ',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text('${_tagged.tag}'),
                  ],
                ),
                IconButton(
                    icon: Icon(Icons.arrow_forward_ios_rounded),
                    onPressed: () {
                      if (_currentIndex < _listOfTagged.length - 1) {
                        ref.read(mlistIndex.state).state += 1;
                      }
                    }),
              ],
            ),
          ),
          _buildMonthlyCard(context, _tagged),
          Container(
            width: 420,
            height: 400,
            child: ListView.builder(
                itemCount: _tagged.shopDataList.length,
                itemBuilder: (context, index) {
                  ShopData shopsData = _tagged.shopDataList[index];
                  return BluredContainer(
                    child: ExpansionTile(
                      collapsedTextColor: Colors.white,
                      textColor: Colors.white,
                      title: Text('${shopsData.shop.shopName}'),
                      trailing: Text('${shopsData.itemsSum}'),
                      subtitle: Text(
                        'N° items : ' + '${shopsData.countItems}',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.grey,
                        ),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                      ),
                      children: [
                        Container(
                            width: 400,
                            height: 400,
                            child: ItemsListWidget(items: shopsData.allItems)),
                      ],
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Container _buildMonthlyCard(BuildContext context, Tagged tagged) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BluredContainer(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total-amount',
                      //style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      tagged.itemsSum.toString(),
                      //style: AkThemeData.darkThemeData.textTheme.headline4,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total number of items',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      '${tagged.countItems}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
