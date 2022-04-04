import 'package:flutter/material.dart';
import 'package:lkarnet/models/shop/shops_data.dart';

import '../components.dart';
import '../models/statistics/tagged.dart';
import 'dash/month_widget.dart';
import 'home.dart';
import 'shop_details.dart';

class ShopDetailsMain extends ConsumerStatefulWidget {
  const ShopDetailsMain({Key? key, this.shopsData}) : super(key: key);
  final ShopData? shopsData;
  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends ConsumerState<ShopDetailsMain> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _listOfTagged = ref.watch(taggedListMMYYProvider.state).state;
    //var _currentIndex = ref.watch(listIndex.state).state;
    var _tagged = _listOfTagged[ref.watch(tagIndexProvider.state).state];
    //return MonthlyDash();
    return BluredContainer(
      start: 0,
      end: 0,
      borderColorOpacity: 0,
      child: Scaffold(
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        floatingActionButton: MyExpandableFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
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
          leading: Icon(Icons.dashboard, color: Colors.black),
          title: Text(
            'Shop Details',
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
        ),

        // Next, create a SliverList
        body: Column(
          children: [
            Container(
              height: 235,
              width: double.infinity,
              // color: Color.fromARGB(94, 255, 193, 7),
              child: Stack(
                children: [
                  _buildMonthlyCard(context, _tagged),
                  Positioned(
                    top: 195,
                    width: 360,
                    left: MediaQuery.of(context).size.width / 2 - 180,
                    child: _buildSelector(_listOfTagged),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              height: 300,
              width: MediaQuery.of(context).size.width,
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

// build custom listTile

  Widget _buildSelector(List<Tagged> _listOfTagged) {
    return BluredContainer(
      start: 0.5,
      end: 0.5,
      height: 40,
      width: 380,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _listOfTagged.length,
        itemBuilder: (context, index) {
          Tagged tagged = _listOfTagged[index];
          // ref.read(tagedProvider.state).state = tagged;
          // _tagged = tagged;

          return SizedBox(
            width: 100,
            height: 30,
            child: GestureDetector(
              onTap: () => ref.read(tagIndexProvider.state).state = index,
              child: Center(
                child: Text('${tagged.tag}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Color.fromARGB(212, 41, 35, 35))),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildMonthlyCard(BuildContext context, Tagged tagged) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BluredContainer(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total-amount',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    ' ${tagged.itemsSumAfterPayment}',
                    style: Theme.of(context).textTheme.headline3,
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
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '${tagged.itemsSum}',
                    style: Theme.of(context).textTheme.bodyText1,
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
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '${tagged.paymentsSum}',
                    style: Theme.of(context).textTheme.bodyText1,
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
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '${tagged.countItems}',
                    style: Theme.of(context).textTheme.bodyText1,
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
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '${tagged.countPayments}',
                    style: Theme.of(context).textTheme.bodyText1,
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
