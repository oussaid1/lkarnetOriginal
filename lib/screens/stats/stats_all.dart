import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/statistics/tagged.dart';
import 'package:lkarnet/providers/dataprovider/data_providers.dart';
import 'package:lkarnet/widgets/charts.dart';
import '../../widgets/glasswidget.dart';

class StatsAll extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
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
      margin: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
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
            BluredContainer(
              margin: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              height: 240,
              child: LineChartWidgetDate(_listOfTagged),
            ),
            const SizedBox(
              width: 8,
            ),
            BluredContainer(
                margin: EdgeInsets.all(8),
                width: 400,
                height: 220,
                child: ColumnChartWidget(chartData2)),
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
