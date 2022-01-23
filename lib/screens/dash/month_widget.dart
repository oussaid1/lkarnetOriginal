import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/statistics/tagged.dart';
import 'package:lkarnet/widgets/glasswidget.dart';

import '../home.dart';
import '../shop_details.dart';

final tagedProvider = StateProvider<Tagged?>((ref) {
  return null;
});
final tagIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class MonthlyDash extends ConsumerStatefulWidget {
  const MonthlyDash({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<MonthlyDash> createState() => _MonthlyDashState();
}

class _MonthlyDashState extends ConsumerState<MonthlyDash> {
  // Tagged? _tagged;
  @override
  Widget build(BuildContext context) {
    var _listOfTagged = ref.watch(taggedListMMYYProvider.state).state;
    //var _currentIndex = ref.watch(listIndex.state).state;
    var _tagged = _listOfTagged[ref.watch(tagIndexProvider.state).state];
    return new SingleChildScrollView(
      child: BluredContainer(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 70,
              width: 400,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _listOfTagged.length,
                itemBuilder: (context, index) {
                  Tagged tagged = _listOfTagged[index];
                  // ref.read(tagedProvider.state).state = tagged;
                  // _tagged = tagged;

                  return SizedBox(
                    width: 100,
                    height: 60,
                    child: Card(
                      color: Color.fromARGB(226, 214, 148, 148),
                      child: GestureDetector(
                        onTap: () =>
                            ref.read(tagIndexProvider.state).state = index,
                        child: Center(
                          child: Text('${tagged.tag}',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                      color:
                                          Color.fromARGB(214, 247, 247, 247))),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 20),
                _buildMonthlyCard(context, _tagged),
                const SizedBox(height: 10),
                Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 20),
                  width: 400,
                  height: 400,
                  child: GridView.count(
                      childAspectRatio: 1.6,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: _tagged.shopDataList.map((shopsData) {
                        return SizedBox(
                          width: 100,
                          height: 120,
                          child: ShopCircleTile(
                            currency: '\$',
                            shopData: shopsData,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShopDetails(
                                    shopsData: shopsData,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList()),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  _buildMonthlyCard(BuildContext context, Tagged tagged) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BluredContainer(
        width: 420,
        height: 130,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total-amount',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    ' ${tagged.itemsSumAfterPayment}',
                    style: Theme.of(context).textTheme.headline4,
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
    );
  }
}
