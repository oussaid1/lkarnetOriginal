import 'package:flutter/material.dart';
import 'package:lkarnet/widgets/myappbar.dart';

import '../components.dart';
import '../models/statistics/tagged.dart';
import '../widgets/price_curency_widget.dart';
import '../widgets/shop_square_tile.dart';
import 'dash/dashboard.dart';
import 'shop_details.dart';

class ShopDetailsMain extends ConsumerStatefulWidget {
  const ShopDetailsMain({
    Key? key,
  }) : super(key: key);
  //final ShopData? shopsData;
  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends ConsumerState<ShopDetailsMain> {
  Tagged? _tagged;

  //var _isSelected = false;
  @override
  void initState() {
    //  _tagged = Tagged.fakeTagged();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _listOfTagged = ref.watch(taggedListMMYYProvider.state).state;
    //var _currentIndex = ref.watch(listIndex.state).state;
    // var _tagged = _listOfTagged[ref.watch(tagIndexProvider.state).state];
    //return MonthlyDash();
    _tagged == null ? _tagged = _listOfTagged[0] : _tagged;
    return BluredContainer(
      start: 0,
      end: 0,
      borderColorOpacity: 0,
      child: Scaffold(
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        floatingActionButton: MyExpandableFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: MyAppBar(
          title: Text(
            '${_tagged!.date!.mMMyy()}',
          ),
          leading: Icon(Icons.calendar_month, color: Colors.black),
        ),

        // Next, create a SliverList
        body: Column(
          children: [
            const SizedBox(
              height: 40,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Monthly',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(186, 255, 255, 255),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              height: 235,
              width: double.infinity,
              // color: Color.fromARGB(94, 255, 193, 7),
              child: Stack(
                //fit: StackFit.loose,
                children: [
                  _buildMonthlyCard(context, _tagged!),
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
            _tagged == null
                ? SizedBox.shrink()
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.5,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      itemCount: _tagged!.shopDataList.length,
                      itemBuilder: (context, index) {
                        return ShopSquareTile(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopDetails(
                                shopData: _tagged!.shopDataList[index],
                              ),
                            ),
                          ),
                          shopData: _tagged!.shopDataList[index],
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
              onTap: () {
                setState(() {
                  tagged.seledcted = !tagged.seledcted;

                  _tagged = tagged;
                });
              },
              child: Card(
                color: _tagged == tagged
                    ? AppConstants.primaryColor
                    : AppConstants.whiteOpacity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // tagged == _tagged ? Text('Selected') : Text(''),
                    Text(
                      tagged.tag,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
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
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  PriceNumberZone(
                      right: const SizedBox.shrink(),
                      withDollarSign: true,
                      price: tagged.itemsSumAfterPayment,
                      style: Theme.of(context).textTheme.headline2!),
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppConstants.whiteOpacity),
                  ),
                  PriceNumberZone(
                    right: const SizedBox.shrink(),
                    withDollarSign: true,
                    price: tagged.itemsSum,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppConstants.hintColor,
                        ),
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppConstants.whiteOpacity),
                  ),
                  PriceNumberZone(
                    right: const SizedBox.shrink(),
                    withDollarSign: true,
                    price: tagged.paymentsSum,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppConstants.hintColor,
                        ),
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppConstants.whiteOpacity),
                  ),
                  PriceNumberZone(
                    right: const SizedBox.shrink(),
                    withDollarSign: true,
                    price: tagged.countItems.toDouble(),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppConstants.hintColor,
                        ),
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppConstants.whiteOpacity),
                  ),
                  PriceNumberZone(
                    right: const SizedBox.shrink(),
                    withDollarSign: true,
                    price: tagged.countPayments.toDouble(),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppConstants.hintColor,
                        ),
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
