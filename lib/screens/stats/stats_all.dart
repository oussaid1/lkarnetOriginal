import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/statistics/tagged.dart';
import 'package:lkarnet/providers/dataprovider/data_providers.dart';
import 'package:lkarnet/widgets/charts.dart';
import 'package:lkarnet/widgets/myappbar.dart';
import '../../widgets/glasswidget.dart';
import '../dash/dashboard.dart';

class StatsAll extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    var chartData = ref.watch(frequentItemsProvider.state).state;
    var chartData2 = ref.watch(shopsChartsDataProvider.state).state;

    var _listOfTagged = ref.watch(taggedListMMYYProvider.state).state;
    return Scaffold(
      appBar: MyAppBar(
        title: Text("All Statistics"),
      ),
      backgroundColor: Colors.transparent,
      floatingActionButton: MyExpandableFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Wrap(
          //mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(width: 12),
            BluredContainer(
              margin: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              height: 240,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LineChartWidgetDate(_listOfTagged),
              ),
            ),
            BluredContainer(
              margin: EdgeInsets.all(8),
              width: 410,
              height: 300,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Most Frequent Products',
                        style: Theme.of(context).textTheme.headline4),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(width: 410, height: 240, child: PeiWidget(chartData))
                ],
              ),
            ),
            BluredContainer(
              margin: EdgeInsets.all(8),
              width: 400,
              height: 220,
              child: ColumnChartWidget(chartData2),
            ),
            const SizedBox(
              width: 100,
            ),
          ],
        ),
      ),
    );
  }
}
