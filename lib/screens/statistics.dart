import 'package:lkarnet/components.dart';
import 'package:flutter/material.dart';

import '../models/payment/payment_model.dart';
import '../models/shop/shops_data.dart';
import 'home.dart';
import 'lists/items.dart';

class StatisticsWidget extends StatefulWidget {
  const StatisticsWidget({Key? key, this.shopsData}) : super(key: key);
  final ShopData? shopsData;
  @override
  _StatisticsWidgetState createState() => _StatisticsWidgetState();
}

class _StatisticsWidgetState extends State<StatisticsWidget> {
  @override
  Widget build(BuildContext context) {
    return GlassMaterial(
      circleWidgets: [
        Positioned(
          width: 140,
          height: 140,
          left: 10,
          top: 120,
          child: AppAssets.blueCircleWidget,
        ),
        Positioned(
          width: 180,
          height: 180,
          right: 80,
          top: 200,
          child: AppAssets.purpleCircleWidget,
        ),
        Positioned(
          width: 180,
          height: 180,
          left: 40,
          bottom: 80,
          child: AppAssets.pinkCircleWidget,
        ),
      ],
      gradientColors: [
        Color.fromARGB(255, 48, 237, 171),
        Color.fromARGB(255, 48, 209, 237),
      ],
      centerWidget: Scaffold(
        floatingActionButton: MyExpandableFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.transparent,
        appBar: buildAppBar(context, title: 'Shop Details'),
        body: SingleChildScrollView(
          child: BluredContainer(
            start: 0,
            end: 0,
            borderColorOpacity: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${widget.shopsData!.shop.shopName}',
                            style: Theme.of(context).textTheme.headline2),
                        Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text('Today',
                                style: Theme.of(context).textTheme.headline3!
                                // .copyWith(color: Colors.white),
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 390,
                    height: 300,
                    child: BluredContainer(
                      child: Column(
                        children: [
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Items',
                                      style:
                                          Theme.of(context).textTheme.headline3!
                                      // .copyWith(color: Colors.white),
                                      ),
                                  Text(
                                      'count :${widget.shopsData!.countItems} ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                  Text('total : ${widget.shopsData!.itemsSum} ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return ItemTileWidget(
                                    item: widget.shopsData!.allItems[index]);
                              },
                              itemCount: widget.shopsData!.allItems.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 390,
                    height: 260,
                    child: BluredContainer(
                      child: Column(
                        children: [
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Payments',
                                      style:
                                          Theme.of(context).textTheme.headline3!
                                      // .copyWith(color: Colors.white),
                                      ),
                                  Text(
                                      'count :${widget.shopsData!.countPayments} ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                  Text(
                                      'total : ${widget.shopsData!.paymentsSum} ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return buildShopPaymentTile(
                                    widget.shopsData!.allPayments[index]);
                              },
                              itemCount: widget.shopsData!.allPayments.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// build custom listTile
  Widget buildShopPaymentTile(Payment payment) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radius),
      ),
      color: AppConstants.whiteOpacity,
      child: SizedBox(
        height: 50,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 19, 174, 235),
                    // : Color(0xA4E6218D),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppConstants.radius),
                      bottomLeft: Radius.circular(AppConstants.radius),
                    ),
                  ),
                  child: Icon(
                    Icons.attach_money_outlined,
                    color: Colors.white.withOpacity(0.5),
                    size: 30,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${payment.datePaid.formatted()}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '${payment.paidAmount.toPrecision()}',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      Text(
                        'DH',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const SizedBox(width: 8),
                    ],
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
