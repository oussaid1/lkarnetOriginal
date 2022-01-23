import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/const/constents.dart';
import 'package:lkarnet/models/statistics/statistics_model.dart';
import 'package:lkarnet/providers/dataprovider/data_providers.dart';
import 'package:lkarnet/widgets/day_barchart.dart';

import '../../widgets/glasswidget.dart';

class StatsAll extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    var chartData = ref.watch(frequentItemsProvider.state).state;
    var chartData2 = ref.watch(shopsChartsDataProvider.state).state;
    return SingleChildScrollView(
      child: BluredContainer(
        margin: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
                          itemCount: chartData.length,
                          itemBuilder: ((context, index) {
                            ChartData _chartData = chartData[index];
                            return SizedBox(
                              height: 57,
                              child: Card(
                                color: AppConstants.whiteOpacity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${_chartData.tag}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                        Text('${_chartData.value}'),
                                      ],
                                    ),
                                    const SizedBox(width: 4),
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
