import 'package:flutter/material.dart';
<<<<<<< HEAD
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
=======
import 'package:lkarnet/models/shop/shops_data.dart';

import '../components.dart';
import '../models/statistics/tagged.dart';
import 'dash/month_widget.dart';
import 'home.dart';
import 'shop_details.dart';

class ShopDetailsMain extends ConsumerStatefulWidget {
  const ShopDetailsMain({Key? key, this.shopsData}) : super(key: key);
  final ShopData? shopsData;
>>>>>>> b369bdf (thanks Allah)
  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends ConsumerState<ShopDetailsMain> {
<<<<<<< HEAD
  Tagged? _tagged;

  //var _isSelected = false;
  @override
  void initState() {
    //  _tagged = Tagged.fakeTagged();
=======
  @override
  void initState() {
>>>>>>> b369bdf (thanks Allah)
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _listOfTagged = ref.watch(taggedListMMYYProvider.state).state;
    //var _currentIndex = ref.watch(listIndex.state).state;
<<<<<<< HEAD
    // var _tagged = _listOfTagged[ref.watch(tagIndexProvider.state).state];
    //return MonthlyDash();
    _tagged == null ? _tagged = _listOfTagged[0] : _tagged;
=======
    var _tagged = _listOfTagged[ref.watch(tagIndexProvider.state).state];
    //return MonthlyDash();
>>>>>>> b369bdf (thanks Allah)
    return BluredContainer(
      start: 0,
      end: 0,
      borderColorOpacity: 0,
      child: Scaffold(
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        floatingActionButton: MyExpandableFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
<<<<<<< HEAD
        appBar: MyAppBar(
          title: Text(
            '${_tagged!.date!.mMMyy()}',
          ),
          leading: Icon(Icons.calendar_month, color: Colors.black),
=======
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
>>>>>>> b369bdf (thanks Allah)
        ),

        // Next, create a SliverList
        body: Column(
          children: [
<<<<<<< HEAD
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
=======
>>>>>>> b369bdf (thanks Allah)
            Container(
              height: 235,
              width: double.infinity,
              // color: Color.fromARGB(94, 255, 193, 7),
              child: Stack(
<<<<<<< HEAD
                //fit: StackFit.loose,
                children: [
                  _buildMonthlyCard(context, _tagged!),
=======
                children: [
                  _buildMonthlyCard(context, _tagged),
>>>>>>> b369bdf (thanks Allah)
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
<<<<<<< HEAD
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
=======
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
>>>>>>> b369bdf (thanks Allah)
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
<<<<<<< HEAD
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
=======
              onTap: () => ref.read(tagIndexProvider.state).state = index,
              child: Center(
                child: Text('${tagged.tag}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Color.fromARGB(212, 41, 35, 35))),
>>>>>>> b369bdf (thanks Allah)
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
<<<<<<< HEAD
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  PriceNumberZone(
                      right: const SizedBox.shrink(),
                      withDollarSign: true,
                      price: tagged.itemsSumAfterPayment,
                      style: Theme.of(context).textTheme.headline2!),
=======
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    ' ${tagged.itemsSumAfterPayment}',
                    style: Theme.of(context).textTheme.headline3,
                  ),
>>>>>>> b369bdf (thanks Allah)
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
<<<<<<< HEAD
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
=======
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '${tagged.itemsSum}',
                    style: Theme.of(context).textTheme.bodyText1,
>>>>>>> b369bdf (thanks Allah)
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
<<<<<<< HEAD
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
=======
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '${tagged.paymentsSum}',
                    style: Theme.of(context).textTheme.bodyText1,
>>>>>>> b369bdf (thanks Allah)
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
<<<<<<< HEAD
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
=======
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '${tagged.countItems}',
                    style: Theme.of(context).textTheme.bodyText1,
>>>>>>> b369bdf (thanks Allah)
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
<<<<<<< HEAD
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
=======
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '${tagged.countPayments}',
                    style: Theme.of(context).textTheme.bodyText1,
>>>>>>> b369bdf (thanks Allah)
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
