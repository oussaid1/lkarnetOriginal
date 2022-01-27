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
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
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
                    height: 50,
                    child: Card(
                      color:
                          Color.fromARGB(226, 214, 148, 148).withOpacity(0.5),
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
                                      color: Color.fromARGB(213, 24, 22, 22))),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 40),
                _buildMonthlyCard(context, _tagged),
                const SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 400,
                  height: 400,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10),
                    itemCount: _tagged.shopDataList.length,
                    itemBuilder: (context, index) {
                      return ShopSquareTile(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopDetails(
                              shopData: _tagged.shopDataList[index],
                            ),
                          ),
                        ),
                        shopData: _tagged.shopDataList[index],
                      );
                      // return SizedBox(
                      //   width: 100,
                      //   height: 100,
                      //   child: GestureDetector(
                      //     onTap: () => Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => ShopDetails(
                      //                   shopsData: _tagged.shopDataList[index],
                      //                 ))),
                      //     child: Card(
                      //       color: Color.fromARGB(226, 214, 148, 148),
                      //       child: Center(
                      //         child: Text(
                      //             '${_tagged.shopDataList[index].shop.shopName}',
                      //             textAlign: TextAlign.center,
                      //             style: Theme.of(context)
                      //                 .textTheme
                      //                 .headline4!
                      //                 .copyWith(
                      //                     color: Color.fromARGB(
                      //                         214, 247, 247, 247))),
                      //       ),
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // children: [  ],

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
