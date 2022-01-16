import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/providers/dataprovider/data_providers.dart';
import 'package:lkarnet/widgets/day_barchart.dart';

class StatsAll extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    var chartData = ref.watch(frequentItemsProvider.state).state;
    var chartData2 = ref.watch(shopsChartsDataProvider.state).state;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("10 most frequent items"),
                ),
                SemiPeiWidget(chartData, Text('')),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Text("highest shop consumption"),
                PeiWidget(chartData2),
              ],
            ),
          ),
          SizedBox(height: 50,),
        ],
      ),
    );
  }
}
