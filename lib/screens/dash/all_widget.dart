import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/overalls.dart';
import 'package:lkarnet/models/shop/shops_data.dart';
import 'package:lkarnet/providers/dataprovider/data_providers.dart';
import 'package:lkarnet/widgets/dash_widget.dart';
import 'package:lkarnet/widgets/day_barchart.dart';

class AllDash extends ConsumerWidget {
  const AllDash({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    //final items = ref.watch(itemsProvider.state).state;
    //final payments = ref.watch(paymentsProvider.state).state;
    var _shopsDataList = ref.watch(shopsDataListProvider.state).state;
    var chartData = ref.watch(shopsChartsDataProvider.state).state;
    OverAlls all = ref.watch(overallsProvider.state).state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 240,
          width: 400,
          margin: EdgeInsets.all(8),
          child: SemiPeiWidget(
            chartData,
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text('Total Consumption',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    ' ${all.itemsSumAfterPayment}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 8, bottom: 10),
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _shopsDataList.length,
                itemBuilder: (context, index) {
                  ShopsData shopsData = _shopsDataList[index];
                  return DashWidget(
                    shopsData: shopsData,
                  );
                }),
          ),
        ),
      ],
    );
  }
}
