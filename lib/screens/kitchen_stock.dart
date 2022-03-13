import 'package:flutter/material.dart';
import 'package:lkarnet/components.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../models/kitchen/kitchen_item.dart';
import 'tabs/kitchen_item_detailed.dart';

class KitchenStockHome extends ConsumerStatefulWidget {
  const KitchenStockHome({Key? key}) : super(key: key);

  @override
  ConsumerState<KitchenStockHome> createState() => _KitchenStockHomeState();
}

class _KitchenStockHomeState extends ConsumerState<KitchenStockHome> {
  String filter = '';
  // final TextEditingController _filterController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //  final itemsDistinctClass = ref.watch(itemDistinctsProvider);
    // var chartData = ref.watch(frequentItemsProvider.state).state;
    //var chartData2 = ref.watch(shopsChartsDataProvider.state).state;
    // int _selectedPageIndex = ref.watch(selectedPageIndex.state).state;
    //   var items = ref.watch(itemsProvider.state).state;
    //   var payments = ref.watch(paymentsProvider.state).state;
    //   var shops = ref.watch(shopsProvider.state).state;
    // //  var dataSink = DataSink(shops, items, payments);
    //   // List<ShopsData> _shopsDataList = dataSink.allShopsData;
    //var _listOfTagged = ref.watch(taggedListMMYYProvider.state).state;
    final fakeKitchenItems = KitchenElement.fakeKitchenItems;

    return BluredContainer(
      start: 0,
      end: 0,
      borderColorOpacity: 0,
      child: Scaffold(
        backgroundColor: Colors.transparent,

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KitchenItemDetailsScreen(
                    // availability: (double) {},
                    ),
              ),
            );
            // Dialogs.botomPopUpDialog(
            //   context,
            //   AddItem(),
            // );
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Kitchen Stock'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(200),
            child: SizedBox(
              height: 230,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  _buildMonthlyCard(
                    context,
                  ),
                  Positioned(
                    top: 180,
                    width: 380,
                    left: MediaQuery.of(context).size.width / 2 - 190,
                    child: _buildSelector(),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Next, create a SliverList
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          // height: 340,
          //width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10),
            itemCount: fakeKitchenItems.length,
            itemBuilder: (context, index) {
              return KitchenItemSquareTile(
                onTap: () {},
                kitchenItem: fakeKitchenItems[index],
              );
            },
          ),
        ),
      ),
    );
  }

// build custom listTile

  Widget _buildSelector() {
    return BluredContainer(
      start: 0.5,
      end: 0.5,
      height: 40,
      width: 380,
      child: Container(),
    );
  }

  _buildMonthlyCard(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BluredContainer(
        //  width: 420,
        height: 200,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Most Consumed',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    ' {}',
                    style: Theme.of(context).textTheme.headline3,
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
                    'Total sum of items',
                    style: Theme.of(context).textTheme.bodyText1,
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
                    'Total sum of payments',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '{}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KitchenItemSquareTile extends StatelessWidget {
  const KitchenItemSquareTile({
    Key? key,
    required this.onTap,
    required this.kitchenItem,
  }) : super(key: key);

  final VoidCallback? onTap;
  final KitchenElement kitchenItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: BluredContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      kitchenItem.title.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.fastfood,
                          color: Colors.white.withOpacity(0.5),
                          size: 20,
                        ),
                        Text(
                          '${kitchenItem.category}',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              buildKitchenItemDetail(context,
                  title: 'Status: ',
                  digitWidget: progress(
                      status: '${kitchenItem.quantity}',
                      value: kitchenItem.availability!)),
              buildKitchenItemDetail(context,
                  title: 'Last Bought: ',
                  digitWidget: Text(
                    DateTime.now().formatted(),
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontFamily: 'RobotoCondensed',
                        color:
                            Color.fromARGB(104, 36, 35, 35).withOpacity(0.6)),
                  )),
              buildKitchenItemDetail(context,
                  title: 'Times Bought: ',
                  digitWidget: Text(
                    '12',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color:
                            Color.fromARGB(104, 36, 35, 35).withOpacity(0.6)),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildKitchenItemDetail(BuildContext context,
      {String? title, Widget? digitWidget}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? '',
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.white.withOpacity(0.3)),
          ),
          digitWidget ?? SizedBox.shrink(),
        ],
      ),
    );
  }
}

Widget progress({double value = 0, String? status = ''}) {
  return SizedBox(
    width: 30,
    height: 30,
    child: SfRadialGauge(
      // backgroundColor: Colors.white,
      axes: <RadialAxis>[
        RadialAxis(
          labelFormat: '$status',
          labelOffset: 15,
          labelsPosition: ElementsPosition.inside,
          axisLabelStyle:
              GaugeTextStyle(fontSize: 8, fontWeight: FontWeight.bold),
          minimum: 0,
          maximum: 10,
          showLabels: true,
          showTicks: false,
          startAngle: 270,
          endAngle: 270,
          axisLineStyle: AxisLineStyle(
            thickness: 0.05,
            color: Color.fromARGB(38, 255, 255, 255),
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          pointers: <GaugePointer>[
            RangePointer(
              color: Color.fromARGB(99, 255, 255, 255),
              value: value,
              width: 0.95,
              pointerOffset: 0.05,
              sizeUnit: GaugeSizeUnit.factor,
            )
          ],
        )
      ],
    ),
  );
}
//     return BluredContainer(
//       margin: EdgeInsets.all(20),
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 40,
//               child: TextField(
//                 controller: _filterController,
//                 onChanged: (value) {
//                   setState(() {
//                     filter = value;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Search',
//                   suffixIcon: IconButton(
//                       icon: Icon(Icons.clear),
//                       onPressed: () => _filterController.clear()),
//                   prefixIcon: Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               width: 400,
//               height: 200,
//               margin: EdgeInsets.symmetric(horizontal: 20),
//               child: ListView.builder(
//                 itemBuilder: (context, index) {
//                   String itemName = itemsDistinctClass.distinctItemNames
//                       .where((element) => element.trim().contains(filter))
//                       .toList()[index];
//                   return ListTile(
//                     title: Text(
//                       itemName.split(" ")[0],
//                       style: Theme.of(context).textTheme.headline4,
//                     ),
//                   );
//                 },
//                 itemCount: itemsDistinctClass.distinctItemNames
//                     .where((element) => element.contains(filter))
//                     .toList()
//                     .length,
//               ),
//             ),
//             Container(
//               color: Colors.white.withOpacity(0.5),
//               width: 400,
//               height: 260,
//               margin: EdgeInsets.symmetric(horizontal: 20),
//               child: ListView.builder(
//                 itemCount: chartData.length,
//                 itemBuilder: (context, index) {
//                   ChartData chartD = chartData[index];
//                   return ListTile(
//                     title: Text(
//                       chartD.tag,
//                       style: Theme.of(context).textTheme.headline4,
//                     ),
//                     subtitle: Text(
//                       '${chartD.count} times',
//                       style: Theme.of(context).textTheme.headline4,
//                     ),
//                     trailing: Text(
//                       '${chartD.value} \$',
//                       style: Theme.of(context).textTheme.headline4,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
