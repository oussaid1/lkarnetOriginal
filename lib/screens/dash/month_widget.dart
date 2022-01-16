import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/shop/shops_data.dart';
import 'package:lkarnet/models/statistics/tagged.dart';
import 'package:lkarnet/widgets/dash_widget.dart';

final listIndex = StateProvider<int>((ref) {
  return 0;
});

class MonthlyDash extends ConsumerWidget {
  const MonthlyDash({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var _listOfTagged = ref.watch(taggedListMMYYProvider.state).state;
    var _currentIndex = ref.watch(listIndex.state).state;

    final _tagged = _listOfTagged[_currentIndex];

    return new SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: const Icon(Icons.arrow_back_ios_rounded),
                    onPressed: () {
                      if (_currentIndex > 0) ref.read(listIndex.state).state--;
                    }),
                Row(
                  children: [
                    Text(
                      'Month: ',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text('${_tagged.tag}'),
                  ],
                ),
                IconButton(
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                    onPressed: () {
                      if (_currentIndex < _listOfTagged.length - 1) {
                        ref.read(listIndex.state).state += 1;
                      }
                    }),
              ],
            ),
          ),
          _buildMonthlyCard(context, _tagged),
          Container(
            width: 420,
            height: 300,
            child: ListView.builder(
                itemCount: _tagged.shopDataList.length,
                itemBuilder: (context, index) {
                  ShopsData shopsData = _tagged.shopDataList[index];
                  return DashWidget(shopsData: shopsData);
                }),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Container _buildMonthlyCard(BuildContext context, Tagged tagged) {
    return Container(
      height: 160,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total-amount',
                      //style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      ' ${tagged.itemsSumAfterPayment}',
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
                      'Total sum of items',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      '${tagged.itemsSum}',
                      style: Theme.of(context).textTheme.subtitle2,
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
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      '${tagged.paymentsSum}',
                      style: Theme.of(context).textTheme.subtitle2,
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
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total number of payments',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      '${tagged.countPayments}',
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

