import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/statistics/tagged.dart';
import 'package:lkarnet/providers/dataprovider/data_providers.dart';
import 'package:lkarnet/widgets/charts.dart';
import '../../const/constents.dart';
import '../../widgets/glasswidget.dart';
import '../home.dart';

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
    return Scaffold(
      appBar: buildAppBar(context, title: "Statistics"),
      backgroundColor: Colors.transparent,
      floatingActionButton: MyExpandableFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
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
              width: MediaQuery.of(context).size.width,
              height: 240,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LineChartWidgetDate(_listOfTagged),
              ),
            ),
            const SizedBox(width: 12),
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

  AppBar buildAppBar(BuildContext context, {String? title}) {
    return AppBar(
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
      leading: Icon(Icons.bar_chart, color: Colors.black),
      title: Text(
        title ?? '',
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
    );
  }
}
