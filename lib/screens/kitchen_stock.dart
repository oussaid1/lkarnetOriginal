import 'package:flutter/material.dart';
import 'package:lkarnet/components.dart';
import 'package:lkarnet/models/item_distincts.dart';
import 'package:lkarnet/models/statistics/statistics_model.dart';

import '../models/statistics/tagged.dart';
import '../providers/dataprovider/data_providers.dart';

class KitchenStockHome extends ConsumerStatefulWidget {
  const KitchenStockHome({Key? key}) : super(key: key);

  @override
  ConsumerState<KitchenStockHome> createState() => _KitchenStockHomeState();
}

class _KitchenStockHomeState extends ConsumerState<KitchenStockHome> {
  String filter = '';
  final TextEditingController _filterController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final itemsDistinctClass = ref.watch(itemDistinctsProvider);
    var chartData = ref.watch(frequentItemsProvider.state).state;
    var chartData2 = ref.watch(shopsChartsDataProvider.state).state;
    // int _selectedPageIndex = ref.watch(selectedPageIndex.state).state;
    //   var items = ref.watch(itemsProvider.state).state;
    //   var payments = ref.watch(paymentsProvider.state).state;
    //   var shops = ref.watch(shopsProvider.state).state;
    // //  var dataSink = DataSink(shops, items, payments);
    //   // List<ShopsData> _shopsDataList = dataSink.allShopsData;
    var _listOfTagged = ref.watch(taggedListMMYYProvider.state).state;
    return BluredContainer(
      margin: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: TextField(
                controller: _filterController,
                onChanged: (value) {
                  setState(() {
                    filter = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => _filterController.clear()),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              width: 400,
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  String itemName = itemsDistinctClass.distinctItemNames
                      .where((element) => element.trim().contains(filter))
                      .toList()[index];
                  return ListTile(
                    title: Text(
                      itemName.split(" ")[0],
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  );
                },
                itemCount: itemsDistinctClass.distinctItemNames
                    .where((element) => element.contains(filter))
                    .toList()
                    .length,
              ),
            ),
            Container(
              color: Colors.white.withOpacity(0.5),
              width: 400,
              height: 260,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: chartData.length,
                itemBuilder: (context, index) {
                  ChartData chartD = chartData[index];
                  return ListTile(
                    title: Text(
                      chartD.tag,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    subtitle: Text(
                      '${chartD.count} times',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    trailing: Text(
                      '${chartD.value} \$',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
