import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/const/constents.dart';
import 'package:lkarnet/models/statistics/statistics_model.dart';
import 'package:lkarnet/providers/dataprovider/data_providers.dart';
import 'package:lkarnet/screens/home.dart';
import 'package:lkarnet/widgets/day_barchart.dart';

import '../../models/shop/shops_data.dart';
import '../../providers/streamproviders/items_stream_provider.dart';
import '../../providers/streamproviders/payments_stream_provider.dart';
import '../../providers/streamproviders/shops_stream_provider.dart';
import '../../providers/varproviders/var_providers.dart';
import '../../widgets/glasswidget.dart';

class StatsAll extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    var chartData = ref.watch(frequentItemsProvider.state).state;
    var chartData2 = ref.watch(shopsChartsDataProvider.state).state;
    final _currency = ref.watch(currencyProvider.state).state;
    int _selectedPageIndex = ref.watch(selectedPageIndex.state).state;
    var items = ref.watch(itemsProvider.state).state;
    var payments = ref.watch(paymentsProvider.state).state;
    var shops = ref.watch(shopsProvider.state).state;
    var dataSink = DataSink(shops, items, payments);
    // List<ShopsData> _shopsDataList = dataSink.allShopsData;

    return BluredContainer(
      margin: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            BluredContainer(
              margin: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              height: 240,
              child: LineChartWidget(chartData),
            ),
            BluredContainer(
              margin: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              height: 240,
              child: Row(
                children: [
                  BluredContainer(
                      width: 120,
                      height: 200,
                      child: ListView.builder(
                          itemCount:
                              dataSink.itemsDataForAll.countSumItems.length,
                          itemBuilder: ((context, index) {
                            ItemsChartData _chartData =
                                dataSink.itemsDataForAll.countSumItems[index];
                            return SizedBox(
                              height: 57,
                              child: Card(
                                color: AppConstants.whiteOpacity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${_chartData.itemName}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        Text('${_chartData.itemCount}'),
                                      ],
                                    ),
                                    Text('${_chartData.itemPrix}'),
                                  ],
                                ),
                              ),
                            );
                          }))),
                  const SizedBox(
                    width: 8,
                  ),
                  BluredContainer(
                      width: 240,
                      height: 200,
                      child: ColumnChartWidget(chartData2)),
                ],
              ),
            ),
            BluredContainer(
              margin: EdgeInsets.all(8),
              width: 410,
              height: 220,
              child: SizedBox(
                width: 420,
                height: 300,
                child: PeiWidget(chartData),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//  Container(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text("10 most frequent items"),
//                   ),
//                   SemiPeiWidget(chartData, Text('')),
//                 ],
//               ),
//             ),
//             Container(
//               child: Column(
//                 children: [
//                   Text("highest shop consumption"),
//                   PeiWidget(chartData2),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 50,
//             ),
